from collections import defaultdict
from functools import lru_cache
from typing import List
from math import lcm
from itertools import product, combinations


class Solution:
    def minimumIncrements(self, nums: List[int], target: List[int]) -> int:
        k = len(target)
        glcm = lcm(*target)
        gtotal = float("inf")
        mins = [
            (
                c,
                [(float("inf"), -1)] * (k if i == 1 else 2),
            )
            for i in range(1, max(2, k))
            for c in combinations(target, i)
        ]

        for i in range(len(nums)):
            glcm_val = (-nums[i]) % glcm
            if glcm_val < gtotal:
                gtotal = glcm_val
            for j in range(len(mins)):
                olddist = max(mins[j][1])
                newdist = (-nums[i]) % lcm(*mins[j][0])
                if newdist < olddist[0]:
                    mins[j][1].remove(olddist)
                    mins[j][1].append((newdist, i))

        nums = [nums[ind] for ind in {amin[1] for t_or_comb in mins for amin in t_or_comb[1]}]

        total_min = float("inf")
        for places in product(range(len(nums)), repeat=k):
            groups = defaultdict(list)  # (*)
            for i, n in enumerate(places):
                groups[n].append(target[i])
            total = 0
            for n, targets in groups.items():
                total += (-nums[n]) % lcm(*targets)
            if total < total_min:
                total_min = total

        return min(gtotal, total_min)


# (*)
# example of meaning:
# 3 7 7 1  <- indices of nums
# 0 1 2 3  <- indices of target (t)
# -> 1: [t3], 3: [t0], 7: [t1, t2]
#               key -> ^   ^^^^^^ <- targets


@lru_cache
def cached_lcm(*items):
    return lcm(*items)


class Solution2:
    def minimumIncrements(self, nums: List[int], target: List[int]) -> int:
        while len(target) < 4:
            target.append(1)

        def cost(x, real_submask):
            if not real_submask:
                return 0
            targets = [target[i] for i in range(4) if real_submask & (1 << i)]
            return (-x) % cached_lcm(*targets)

        dp = [0] + [float("inf")] * 15
        for num in nums:
            res = [0] + [float("inf")] * 15
            for mask in range(16):
                for submask in range(16):
                    mask_new = mask | submask
                    real_submask = submask & ~mask
                    res[mask_new] = min(res[mask_new], dp[mask] + cost(num, real_submask))
            for i in range(16):
                dp[i] = res[i]
        return dp[0b1111]


def main():
    print(
        Solution().minimumIncrements(
            nums=list(map(int, input().split(", "))),
            target=list(map(int, input().split(", "))),
        )
    )


if __name__ == "__main__":
    main()
