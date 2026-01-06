from time import time

FILE = '/Users/rayskiy7/Downloads/googlebooks-eng-all-1gram-20120701-a'


def main():
    result = {}
    with open(FILE) as file:
        lines = file.readlines()

    start = time()
    for line in lines:
        values = line.split('\t')
        word, count = values[0], int(values[2])
        result[word] = result.get(word, 0) + count
    end = time()
    print(f'aardvark seemed {result['aardvark']} times. Estimated: {end-start:.4f} seconds')


if __name__ == '__main__':
    main()
