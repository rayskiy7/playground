from time import time
import typing as tp
import asyncio
import concurrent.futures as concfu
import functools


FILE = '/Users/rayskiy7/Downloads/googlebooks-eng-all-1gram-20120701-a'
CHUNK_SIZE = 60_000


def get_parts_iterator(data, chunk_size=CHUNK_SIZE):
    for i in range(0, len(data), chunk_size):
        yield data[i:i+chunk_size]


def get_dicts(dicts_list):
    chunk_size = 500  # max(len(dicts_list) // 10, 2)
    for i in range(0, len(dicts_list), chunk_size):
        yield dicts_list[i:i+chunk_size]


def merge_dicts(dicts):
    return functools.reduce(reducer, dicts)


def map(chunk: tp.List) -> tp.Dict:
    counts = {}
    for line in chunk:
        values = line.split('\t')
        word, count = values[0], int(values[2])
        counts[word] = counts.get(word, 0) + count
    return counts


def reducer(counts1, counts2):
    result_counts = counts1
    for word, count in counts2.items():
        result_counts[word] = result_counts.get(word, 0) + count

    return result_counts


async def main():
    with open(FILE) as file:
        data = file.readlines()
    start = time()
    event_loop = asyncio.get_running_loop()
    with concfu.ProcessPoolExecutor() as process_pool:
        tasks = (
            event_loop.run_in_executor(
                process_pool,
                functools.partial(map, chunk)
            )
            for chunk in get_parts_iterator(data)
        )
        results = await asyncio.gather(*tasks)
        while len(results) > 1:
            reduce_tasks = [
                event_loop.run_in_executor(
                    process_pool,
                    functools.partial(merge_dicts, chunk)
                )
                for chunk in get_dicts(results)
            ]
            results = await asyncio.gather(*reduce_tasks)
    end = time()

    print(f'{results[0]['aardvark']}, estimated: {end-start:.4f}')


if __name__ == '__main__':
    asyncio.run(main())
