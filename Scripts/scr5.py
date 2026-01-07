import os
from pathlib import Path
from datetime import datetime, timedelta, timezone
import pprint
from typing import Dict, List
from PIL import Image
from PIL.ExifTags import TAGS
import subprocess
import json

MSK = timezone(timedelta(hours=3))   # UTC+3

def get_fs_datetime(path: Path):
    stat = path.stat()
    # ctime на macOS — creation time
    dt = datetime.fromtimestamp(stat.st_birthtime)
    if not dt:
        raise RuntimeError(f"no path stat for {path}")
    return dt

# Получение даты создания для JPG через EXIF
def get_jpg_datetime(path: Path):
    try:
        img = Image.open(path)
        exif = img._getexif()
        if not exif:
            raise RuntimeError(f"no exif for {path}")

        for tag_id, value in exif.items():
            tag = TAGS.get(tag_id, tag_id)
            if tag == "DateTimeOriginal":
                return datetime.strptime(value, "%Y:%m:%d %H:%M:%S")
    except:
        raise RuntimeError("Unexpected error in get_jpg_datetime")
    raise RuntimeError("no result in get_jpg_datetime")
    

# Получение даты создания для MOV через ffprobe (нужно наличие ffmpeg)
def get_mov_datetime(path: Path):
    try:
        cmd = [
            "ffprobe", "-v", "quiet", "-print_format", "json",
            "-show_format", "-show_streams", str(path)
        ]
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        data = json.loads(result.stdout)

        date_str = data["format"].get("tags", {}).get("creation_time")
        if date_str:
            dt = datetime.fromisoformat(date_str.replace("Z", "+00:00"))
            dt = dt.astimezone(MSK)
            dt = dt.replace(tzinfo=None)
            return dt

    except:
        raise RuntimeError("Unexpected error in get_mov_datetime")
    raise RuntimeError("no result in get_mov_datetime")

a, b = 0, 0

def get_stamp(path: Path):
    global a, b
    ext = path.suffix.lower()
    if ext in [".jpg"]:
        try:
            dt = get_jpg_datetime(path)
            if dt:
                return dt
        except:
            # Fallback → файловая дата
            a+=1
            return get_fs_datetime(path)

    elif ext in [".mov"]:
        try:
            dt = get_mov_datetime(path)
            if dt:
                return dt
        except:
            # MOV fallback → файловая дата (в MSK)
            b+=1
            return get_fs_datetime(path)

def get_files(path: str):
    folder = Path(path)
    return [f for f in folder.iterdir() if f.is_file()
            and f.name != '.DS_Store']


def check_exts(files: List[Path]):
    for f in files:
        if f.suffix.lower() not in {'.jpg', '.mov', '.png'}:
            raise RuntimeError(f"wrong ext file: {f}")


def get_order(file_paths: List[Path]):
    stamps = {}
    for f in file_paths:
        stamps[f] = get_stamp(f)
    groups = {}
    for f, st in sorted(stamps.items(), key=lambda p: p[1]):
        d = st.strftime("%Y%m%d")[2:]
        groups[d] = groups.get(d, 0) + 1
    res = {}
    prev = None
    n = 0
    for f, st in sorted(stamps.items(), key=lambda p: p[1]):
        d = st.strftime("%Y%m%d")[2:]
        if prev != d:
            n = 0
            prev = d
        else:
            n += 1
        res[f] = (d, n, groups[d])
    return res


def get_groups(stamps: Dict[Path, datetime]):
    for k, v in stamps.items():
        pass


# Запуск:
# rename_media("/path/to/folder")

WORKPTH = '/Users/rayskiy7/Library/Mobile Documents/com~apple~CloudDocs/10. Materials/1. People/Отчим'

def main(pp):
    # Check files extensions
    file_paths = get_files(pp)
    check_exts(file_paths)

    queries = get_order(file_paths)
    for f, (d, k, n) in queries.items():
        newname = d + (f" {k+1}" if n>1 else "") + f.suffix.lower()
        newpath = f.with_name(newname)
        print(f"rename:\n\t{f}\n\t\t->{newname}")
        f.rename(newpath)
    print(f"jpg with fs: {a}\nmov with fs: {b}")

main(WORKPTH)

# f1, f2, f3
# f1 -> 210513 15:27 0, 3
# f2 -> 210513 16:28 1, 3
# f3 -> 210513 16:28 2, 3
#
# f1 -> f2 -> f3
# 