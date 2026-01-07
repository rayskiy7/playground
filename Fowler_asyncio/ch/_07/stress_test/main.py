import asyncio
import threading as th
from .window_class import LoadTester


class ThreadedEventLoop(th.Thread):

    def __init__(self, loop: asyncio.AbstractEventLoop):
        super().__init__()
        self._loop = loop
        self.daemon = True

    def run(self):
        self._loop.run_forever()


def main():
    loop = asyncio.new_event_loop()

    asyncio_thread = ThreadedEventLoop(loop)
    asyncio_thread.start()

    app = LoadTester(loop)
    app.mainloop()
