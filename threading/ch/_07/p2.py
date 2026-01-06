import concurrent.futures as concfu
import requests
import time


def get_status_code(url):
    response = requests.get(url)
    return response.status_code


def main():
    start = time.time()
    with concfu.ThreadPoolExecutor() as thread_pool:
        results = thread_pool.map(get_status_code, ('https://example.com' for _ in range(1000)))
        for res in results:
            print(res)
    end = time.time()
    print(end-start)


def sync():
    start = time.time()
    for _ in range(1000):
        print(get_status_code('https://example.com'))
    end = time.time()
    print(end-start)


sync()
