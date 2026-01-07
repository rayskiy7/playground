import tty
import shutil
import asyncio
import sys
import os
from collections import deque


def save_cursor_position():
    sys.stdout.write('\0337')


def restore_cursor_position():
    sys.stdout.write('\0338')


def move_to_top_of_screen():
    sys.stdout.write('\033[H')


def delete_line():
    sys.stdout.write('\033[2K')


def clear_line():
    sys.stdout.write('\033[2K\033[0G')


def move_back_one_char():
    sys.stdout.write('\033[1D')


def move_to_bottom_of_screen(rows):
    sys.stdout.write(f'\033[{rows}E')


class Terminal:
    def __init__(self):
        tty.setcbreak(sys.stdin)
        os.system('clear')
        _, rows = shutil.get_terminal_size()
        self._deque = deque(maxlen=rows - 2)
        move_to_bottom_of_screen(rows - 1)
        sys.stdout.flush()

    def __await__(self):
        self._reader = asyncio.StreamReader()
        loop = asyncio.get_running_loop()
        protocol = asyncio.StreamReaderProtocol(self._reader)
        yield from loop.connect_read_pipe(lambda: protocol, sys.stdin).__await__()
        return self

    def print(self, message, endl=False):
        self._deque.append(message)
        self._refill_screen(endl)
        sys.stdout.flush()

    def _refill_screen(self, endl):
        save_cursor_position()
        move_to_top_of_screen()
        for message in self._deque:
            delete_line()
            print(message, end="\n" if endl else "")
        restore_cursor_position()

    async def input(self):
        buffer = deque()
        delete_char = b'\x7f'
        while (char := await self._reader.read(1)) != b'\n':
            if char == delete_char:
                if buffer:
                    buffer.pop()
                    move_back_one_char()
                    sys.stdout.write(' ')
                    move_back_one_char()
            else:
                buffer.append(char)
                sys.stdout.write(char.decode())
            sys.stdout.flush()

        clear_line()
        sys.stdout.flush()
        return b''.join(buffer).decode()
