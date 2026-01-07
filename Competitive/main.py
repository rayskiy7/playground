import subprocess
import os
import sys

from utils import Settings, WrongAnswerException, parse_problems


def run_test(input, expected_output, solution_path):
    proc = subprocess.run(
        [sys.executable, "-u", solution_path],
        input=input.encode(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        timeout=Settings.TIME_LIMIT,
        check=True,
    )
    output = proc.stdout.decode().rstrip()
    if output != expected_output:
        raise WrongAnswerException(output)


def main():
    for problem_name, tests, solution_path in parse_problems(os.path.dirname(os.path.abspath(__file__))):
        print(f'Testing solution for problem "{problem_name}"...')
        for n, test in enumerate(tests, start=1):
            try:
                run_test(test.input, test.expected_output, solution_path)
            except subprocess.TimeoutExpired:
                print(f"\tTEST {n} - TIMEOUT ERROR")
                break
            except WrongAnswerException as e:
                print(f"\tTEST {n} - WRONG ANSWER")
                print(f"\texpected: {test.expected_output}")
                print(f"\t     got: {e}")
                break
            except Exception as e:
                print(f"\t TEST{n} - RUNTIME ERROR: {e}")
                break
        else:
            print(f"\tALL TESTS - OK")
        print()


if __name__ == "__main__":
    main()
