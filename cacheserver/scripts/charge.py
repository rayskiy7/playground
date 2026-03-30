import sys
import json
import random
import string
import urllib.request
from datetime import datetime, timedelta, timezone
from concurrent.futures import ThreadPoolExecutor, as_completed

BASE_URL = "http://localhost:8080"
KEYS = [f"key{i}" for i in range(1, 101)]
EXPIRATIONS = [None, 5, 10, 20, 60]

def rfc1123(dt):
    return dt.strftime("%a, %d %b %Y %H:%M:%S GMT")

def random_json():
    size = random.randint(1, 10)
    obj = {}
    for _ in range(size):
        k = ''.join(random.choices(string.ascii_lowercase, k=random.randint(3, 10)))
        v_type = random.choice(["str", "int", "float", "bool", "list"])
        if v_type == "str":
            v = ''.join(random.choices(string.ascii_letters + string.digits, k=random.randint(5, 50)))
        elif v_type == "int":
            v = random.randint(0, 100000)
        elif v_type == "float":
            v = random.random() * 1000
        elif v_type == "bool":
            v = random.choice([True, False])
        else:
            v = [random.randint(0, 100) for _ in range(random.randint(1, 10))]
        obj[k] = v
    return json.dumps(obj).encode()

def put_one(key):
    data = random_json()
    exp = random.choice(EXPIRATIONS)

    headers = {
        "Content-Type": "application/json",
        "Content-Length": str(len(data)),
    }

    label = "-"
    if exp is not None:
        dt = datetime.now(timezone.utc) + timedelta(seconds=exp)
        headers["Expires"] = rfc1123(dt)
        label = f"{exp}s"

    req = urllib.request.Request(
        url=f"{BASE_URL}/objects/{key}",
        data=data,
        method="PUT",
        headers=headers,
    )

    try:
        urllib.request.urlopen(req, timeout=5).read()
    except Exception:
        pass

    return label

def delete_one(key):
    req = urllib.request.Request(
        url=f"{BASE_URL}/objects/{key}",
        method="DELETE",
    )
    try:
        urllib.request.urlopen(req, timeout=5).read()
    except Exception:
        pass
    return key

def mode_add(n):
    counts = {}
    for _ in range(n):
        key = random.choice(KEYS)
        label = put_one(key)
        counts[label] = counts.get(label, 0) + 1

    parts = []
    for k in sorted(counts.keys(), key=lambda x: (x != "-", x)):
        parts.append(f"{k}:{counts[k]}")

    print(f"added {n} objects | " + " ".join(parts))

def mode_del(n):
    keys = random.sample(KEYS, k=min(n, len(KEYS)))

    results = []
    with ThreadPoolExecutor(max_workers=min(32, len(keys))) as ex:
        futures = [ex.submit(delete_one, k) for k in keys]
        for f in as_completed(futures):
            results.append(f.result())

    results.sort()
    print(f"deleted {len(results)} keys | " + " ".join(results))

def main():
    if len(sys.argv) != 3:
        print("usage: charge.py add N | del N")
        sys.exit(1)

    cmd = sys.argv[1]
    try:
        n = int(sys.argv[2])
    except ValueError:
        print("N must be integer")
        sys.exit(1)

    if n <= 0:
        print("N must be > 0")
        sys.exit(1)

    if cmd == "add":
        mode_add(n)
    elif cmd == "del":
        mode_del(n)
    else:
        print("unknown command")
        sys.exit(1)

if __name__ == "__main__":
    main()