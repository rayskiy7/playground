import multiprocessing
import time


def count(n):
    start = time.time()
    i = 0
    while i < n:
        i += 1
    end = time.time()

    print(f'end counting to {n}. estimated: {end-start}')


def main():
    start = time.time()
    first_task = multiprocessing.Process(target=count, args=(100_000_000,))
    second_task = multiprocessing.Process(target=count, args=(200_000_000,))

    first_task.start()
    second_task.start()

    first_task.join()
    second_task.join()

    end = time.time()
    print(f'Total estimated: {end-start}')


if __name__ == '__main__':
    main()
