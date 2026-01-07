import multiprocessing as mp


def increase(val: mp.Value):
    val.get_lock().acquire()
    val.value = val.value + 1
    val.get_lock().release()


def main():
    for _ in range(100):
        counter = mp.Value('i', 0)
        tasks = [mp.Process(target=increase, args=(counter,)),
                 mp.Process(target=increase, args=(counter,))
                 ]
        [task.start() for task in tasks]
        [task.join() for task in tasks]
        print(counter.value)


if __name__ == '__main__':
    main()
