import concurrent.futures as concfu
import requests
import asyncio
import time


def get_status_code(url):
    response = requests.get(url)
    return response.status_code


async def main():
    start = time.time()
    loop = asyncio.get_running_loop()
    with concfu.ThreadPoolExecutor() as thread_pool:
        tasks = [
            loop.run_in_executor(
                thread_pool,
                get_status_code, 'https://example.com'
            )
            for _ in range(1000)
        ]
        for res in await asyncio.gather(*tasks):
            print(res)
    end = time.time()
    print(end-start)


asyncio.run(main())
