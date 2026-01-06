import concurrent.futures
import time


def count(n):
    start = time.time()
    i = 0
    while i < n:
        i += 1
    end = time.time()

    print(f'end counting to {n}. estimated: {end-start}')
    return n


def main():
    with concurrent.futures.ProcessPoolExecutor() as pool:
        times = [1, 5, 1000, 100_000_000]
        for result in pool.map(count, times):
            print(result)


if __name__ == '__main__':
    main()
