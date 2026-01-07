import sys
from functools import lru_cache

sys.setrecursionlimit(2**30)

MOD = 10**9 + 7


@lru_cache
def pairn(l, r):
    if l == r == '?':
        return 3
    if '?' in {l, r} and (l in '([{' or r in ')]}'):
        return 1
    if l+r in {'()', '[]', '{}'}:
        return 1
    return 0
    

@lru_cache(None)
def count(sequence):
    if len(sequence) % 2 != 0:
        return 0
    if len(sequence) == 0:
        return 1
    
    sum = 0
    for k in range(1, len(sequence), 2):
        sum = (sum + pairn(sequence[0], sequence[k])*count(sequence[1:k])*count(sequence[k+1:])) % MOD
    return sum


def main():
    input()
    print(count(input()))


if __name__=='__main__':
    main()
