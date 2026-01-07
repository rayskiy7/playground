import os
from dataclasses import dataclass
from enum import Enum


class WrongAnswerException(Exception):
    pass


@dataclass
class Settings:
    TIME_LIMIT = 2  # sec
    TESTS_FN = "testset.txt"
    SOLUTION_FL = "solution.py"


class Mode(Enum):
    FIND = 1
    READ_IN = 2
    READ_OUT = 3


@dataclass
class Test:
    input: str
    expected_output: str


def parse_tests(path):
    mode = Mode.FIND
    t = Test(input="", expected_output="")
    for line in open(path, "r"):
        if mode == Mode.FIND:
            if line.strip() == "in:":
                mode = Mode.READ_IN
        elif mode == Mode.READ_IN:
            if line.strip() == "out:":
                mode = Mode.READ_OUT
            else:
                t.input += line
        elif mode == Mode.READ_OUT:
            if not line.strip():
                mode = Mode.FIND
                t.expected_output = t.expected_output.rstrip()
                yield t
                t = Test(input="", expected_output="")
            else:
                t.expected_output += line
    if mode == Mode.READ_OUT:
        t.expected_output = t.expected_output.rstrip()
        yield t


def parse_problems(path):
    for name in os.listdir(path):
        folder_path = os.path.join(path, name)
        if os.path.isdir(folder_path):
            solution_path = os.path.join(folder_path, Settings.SOLUTION_FL)
            testset_path = os.path.join(folder_path, Settings.TESTS_FN)
            if os.path.exists(solution_path) and os.path.exists(testset_path):
                yield (name, parse_tests(testset_path), solution_path)
