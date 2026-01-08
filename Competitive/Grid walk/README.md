# Python Performance: Abstractions vs Constants

Here I wanted to run a small experiment to see how much runtime overhead common Python
abstractions actually introduce in practice.

Using a single algorithmic problem, I compared two implementations with identical
asymptotic complexity: one written in a clear, idiomatic Python style, and another
intentionally optimized by removing abstractions in favor of raw data structures.

Both solutions have **identical asymptotic complexity** and use the **same algorithm**.
Any performance difference therefore reflects **constant-factor costs**, not better
algorithmics.

Normally, such micro-optimizations are unnecessary in Python.  
Here, the goal is purely exploratory: intentionally trading clarity for speed to
measure the impact.

**Solution** focuses on readability:
- `@dataclass` for structured data
- custom objects (`Point`)
- `set` for visited tracking
- helper functions and abstractions

**Solution2** is optimized for performance:
- no `dataclass`, no custom objects
- primitive tuples instead of objects
- 2D boolean list instead of `set`
- inlined logic, no lambdas or helpers
- direct use of `heapq` with `(cost, x, y)`

Benchmarking is done using Python’s built-in `timeit` module.

## Results
```bash
$ python3 ./benchmark.py
```

For my machine I've got:
```
====== TIMEIT BENCHMARK ======
Solution 1 total: 0.687788 sec
Solution 2 total: 0.135931 sec

Solution 1 avg: 0.003439 sec
Solution 2 avg: 0.000680 sec

Speedup: 5.06x
==============================
```

The result highlights that while Python abstractions are powerful and expressive,
they carry measurable costs in hot paths — and understanding these trade-offs is an
important part of engineering judgment.