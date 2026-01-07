import threading as th


list_lock = th.RLock()


def sum(ints: list[int]) -> int:
    print('wait for lock')
    with list_lock:
        print('lock is acquired')
        if len(ints) == 0:
            print('finish!')
            return 0
        else:
            one, *tail = ints
            print('summarizing tail')
            return one + sum(tail)


thread = th.Thread(target=sum, args=([1,2,3,4,5,6,7,8,9,10],))
thread.start()
thread.join()
