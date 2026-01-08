import timeit

from solution import Solution, Solution2


# ====== test data ======

GRID = [
    list(range(i * 30, (i + 1) * 30))
    for i in range(30)
]

QUERIES = [0, 1, 10, 100, 300, 450, 899, 900, 901, 2000]

EXPECTED = [0, 1, 10, 100, 300, 450, 899, 900, 900, 900]


# ====== void solutions ======

sol1 = Solution()
sol2 = Solution2()


def run_solution1():
    return sol1.maxPoints(GRID, QUERIES)


def run_solution2():
    return sol2.maxPoints(GRID, QUERIES)


# ====== sanity check ======

assert run_solution1() == EXPECTED
assert run_solution2() == EXPECTED


# ====== benchmark ======

N = 200

t1 = timeit.timeit(run_solution1, number=N)
t2 = timeit.timeit(run_solution2, number=N)

print("====== TIMEIT BENCHMARK ======")
print(f"Solution 1 total: {t1:.6f} sec")
print(f"Solution 2 total: {t2:.6f} sec")
print()
print(f"Solution 1 avg: {t1 / N:.6f} sec")
print(f"Solution 2 avg: {t2 / N:.6f} sec")
print()
print(f"Speedup: {t1 / t2:.2f}x")
print("==============================")
