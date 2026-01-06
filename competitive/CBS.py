# --------------------------------- PROBLEM STATEMENT ---------------------------------
# Given: 
#   A string s of length N consisting of the characters:
#       ( ) [ ] { } ?
#
# A correct bracket sequence (CBS) is defined as:
#   • the empty string is a CBS
#   • if A is a CBS, then (A), [A], {A} are CBS
#   • if A and B are CBS, then AB is a CBS
#
# Each character '?' may be replaced with ANY of the six bracket characters:
#       ( ) [ ] { }
#
# Task:
#   Count the number of different correct bracket sequences that can be obtained
#   after replacing every '?' by brackets.
#
# Input format:
#   N – even integer, length of the string
#   s – the string itself
#
# Output:
#   One integer – number of valid sequences modulo 1_000_000_007
#
# Guarantees:
#   • N is even
#
# Examples:
#
# Example 1:
#   Input:
#       2
#       ??
#   Output:
#       3
#
# Example 2:
#   Input:
#       4
#       (?)?
#   Output:
#       1
#
# Example 3:
#   Input:
#       4
#       ????
#   Output:
#       18
#
# --------------------------------------------------------------------------------------


import sys

sys.setrecursionlimit(2**30)

OPEN = '([{'
CLOSE = ')]}'
MOD = 10**9 + 7


memorized = {}


def count(sequence):  # pass only even numbers
    if sequence in memorized:
        return memorized[sequence]

    if len(sequence) == 0:
        memorized[sequence] = 1
        return 1
    if sequence[0] in CLOSE:
        memorized[sequence] = 0
        return 0

    sumvars = 0
    for k in range(1, len(sequence), 2):
        if sequence[k] in CLOSE or sequence[k] == '?':
            multiplier = 3 if sequence[0] == sequence[k] == '?' else 1
            sumvars += (multiplier * count(sequence[1:k]) * count(sequence[k+1:])) % MOD

    memorized[sequence] = sumvars
    return sumvars


N = int(input())
sequence = input()

print(count(sequence))
