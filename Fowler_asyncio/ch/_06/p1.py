import concurrent.futures
import time


def count(n):
    start = time.time()
    for _ in range(n):
        pass
    end = time.time()
    print(f'end counting to {n}. elapsed: {end-start:.4f}s')
    return n


def main():
    times = [1, 5, 100_000, 100_000_000]
    with concurrent.futures.ProcessPoolExecutor() as pool:
        for result in pool.map(count, times):
            print(result)


if __name__ == '__main__':
    main()
