import sys
import json
import random
import time
import requests
from datetime import datetime, timedelta
from email.utils import formatdate
from concurrent.futures import ThreadPoolExecutor

KEYS = [f"key{i}" for i in range(1, 101)]
EXP_OPTIONS = [None, 5, 10, 20, 60]
BASE_URL = "http://localhost:8080/objects"

def get_rfc1123(seconds):
    dt = datetime.utcnow() + timedelta(seconds=seconds)
    return formatdate(time.mktime(dt.timetuple()), usegmt=True)

def add_entries(count):
    stats = {str(ex): 0 for ex in EXP_OPTIONS}
    
    def worker(_):
        key = random.choice(KEYS)
        exp = random.choice(EXP_OPTIONS)
        data = {"id": random.randint(1000, 9999), "payload": "x" * random.randint(10, 100), "active": True}
        headers = {}
        if exp:
            headers["Expires"] = get_rfc1123(exp)
            stats[str(exp)] += 1
        else:
            stats["None"] += 1
            
        requests.put(f"{BASE_URL}/{key}", json=data, headers=headers)

    with ThreadPoolExecutor(max_workers=10) as executor:
        executor.map(worker, range(count))
    
    print(f"Added {count} entries.")
    for k, v in stats.items():
        print(f"  {k}s: {v}")

def del_entries(count):
    count = min(count, 100)
    to_delete = sorted(random.sample(KEYS, count))
    
    def worker(key):
        requests.delete(f"{BASE_URL}/{key}")

    with ThreadPoolExecutor(max_workers=10) as executor:
        executor.map(worker, to_delete)
        
    print(f"Deleted {len(to_delete)} keys: {', '.join(to_delete)}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 charge.py [add|del] [count]")
        sys.exit(1)
        
    cmd = sys.argv[1]
    num = int(sys.argv[2])
    
    if cmd == "add":
        add_entries(num)
    elif cmd == "del":
        del_entries(num)