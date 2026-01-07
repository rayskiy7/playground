import threading as th
import time
import hashlib

def timer(func):
    def wrapped(*args, **kwargs):
        start = time.time()
        res = func(*args, **kwargs)
        end = time.time()
        print(f'estimated: {end-start:.4f}')
        return res
    return wrapped


@timer
def f():
    for _ in range(4):
        x = 2
        for _ in range(30):
            x**=2
    print('f')

@timer
def g():
    for _ in range(4):
        x = 2
        for _ in range(28):
            x**=2
    print('g')



@timer
def main():
    f()
    g()


main()