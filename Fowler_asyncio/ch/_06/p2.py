import asyncio
import concurrent.futures as concfu
from mine._06.p1 import count
import functools
import random


async def main():
    with concfu.ProcessPoolExecutor() as process_pool:
        event_loop = asyncio.get_running_loop()
        tasks = [
            event_loop.run_in_executor(
                process_pool,
                functools.partial(count, n),
            )
            for n in (random.randint(30, 100)*1_000_000 for _ in range(10))
        ]

        print(await asyncio.gather(*tasks))


if __name__ == '__main__':
    asyncio.run(main())
