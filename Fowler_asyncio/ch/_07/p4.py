import asyncio
import threading as th
import util
import requests

mutex = th.Lock()
MAX = 200
counter = 0


def get_status_code(url):
    response = requests.get(url)
    with mutex:
        global counter
        counter += 1
    return response.status_code


async def reporter():
    while counter < MAX:
        print(f'{counter}/{MAX}')
        await asyncio.sleep(1)


@util.async_timed()
async def main():
    tasks = [asyncio.to_thread(
        get_status_code, 'https://www.example.com'
    ) for _ in range(MAX)]
    tasks.append(reporter())

    results = await asyncio.gather(*tasks)
    print(results)


asyncio.run(main())
