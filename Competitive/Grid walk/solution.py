from dataclasses import dataclass
import heapq
from typing import Iterable


@dataclass(frozen=True, order=True)
class Point:
    x: int
    y: int


class PriorityQueue:
    def __init__(self):
        self.pq_list = []

    def push(self, priority: int, el: Point):
        heapq.heappush(self.pq_list, (priority, el))

    def pop(self) -> tuple[int, Point]:
        priority, el = heapq.heappop(self.pq_list)
        return priority, el

    def __bool__(self) -> bool:
        return bool(self.pq_list)


@dataclass(order=True)
class Query:
    possibly: int
    ind: int
    score: int


class Solution:
    def maxPoints(self, grid: list[list[int]], queries: list[int]):
        N, M = len(grid), len(grid[0])

        def get_neighbours(el: Point) -> Iterable[Point]:
            x, y = el.x, el.y
            new_points = [Point(x + 1, y), Point(x - 1, y), Point(x, y + 1), Point(x, y - 1)]
            return filter(lambda p: 0 <= p.x < M and 0 <= p.y < N, new_points)

        def get_cost(el: Point) -> int:
            return grid[el.y][el.x]

        i = 0
        acc_score = 0
        k = len(queries)
        table = sorted(Query(val, ind, 0) for ind, val in enumerate(queries))

        visited = set()
        q = PriorityQueue()
        q.push(grid[0][0], Point(0, 0))

        while i < k and q:
            cost, el = q.pop()
            if el in visited:
                continue
            else:
                visited.add(el)

            while i < k and not cost < table[i].possibly:
                table[i].score = acc_score
                i += 1

            acc_score += 1
            for n in get_neighbours(el):
                if n not in visited:
                    q.push(max(cost, get_cost(n)), n)

        while i < k:
            table[i].score = acc_score
            i += 1

        res = [0] * k
        for record in table:
            res[record.ind] = record.score

        return res


class Solution2:
    def maxPoints(self, grid, queries):
        n, m = len(grid), len(grid[0])
        k = len(queries)
        table = sorted([(q, i, 0) for i, q in enumerate(queries)])

        visited = [[False] * m for _ in range(n)]
        pq = []
        heapq.heappush(pq, (grid[0][0], 0, 0))  # (cost, x, y)

        i = 0
        acc_score = 0

        while i < k and pq:
            cost, x, y = heapq.heappop(pq)

            if visited[y][x]:
                continue
            visited[y][x] = True

            while i < k and not (cost < table[i][0]):
                qval, qi, _ = table[i]
                table[i] = (qval, qi, acc_score)
                i += 1

            acc_score += 1

            if x + 1 < m and not visited[y][x + 1]:
                heapq.heappush(pq, (max(cost, grid[y][x + 1]), x + 1, y))
            if x - 1 >= 0 and not visited[y][x - 1]:
                heapq.heappush(pq, (max(cost, grid[y][x - 1]), x - 1, y))
            if y + 1 < n and not visited[y + 1][x]:
                heapq.heappush(pq, (max(cost, grid[y + 1][x]), x, y + 1))
            if y - 1 >= 0 and not visited[y - 1][x]:
                heapq.heappush(pq, (max(cost, grid[y - 1][x]), x, y - 1))

        while i < k:
            qval, qi, _ = table[i]
            table[i] = (qval, qi, acc_score)
            i += 1

        res = [0] * k
        for _, qi, score in table:
            res[qi] = score

        return res


def main():
    _, n = map(int, input().split(' '))
    grid = [list(map(int, input().split(', '))) for _ in range(n)]
    input()
    queries = list(map(int, input().split(', ')))
    print(
        ', '.join(map(str,
            Solution().maxPoints(
                grid=grid,
                queries=queries,
            )
        ))
    )


if __name__ == '__main__':
    main()