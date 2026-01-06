from terminal_class import Terminal
import asyncio


class ChatClient:
    def __init__(self, nickname):
        self._nick = nickname

    async def _typing(self, terminal, writer):
        while True:
            text = await terminal.input()
            writer.write(text.encode() + b'\n')
            await writer.drain()

    async def _reading(self, terminal, reader):
        while (text := await reader.readline()) != b'':
            terminal.print(text.decode())

    async def init_account(self, writer):
        writer.write(self._nick.encode()+b'\n')
        await writer.drain()

    async def start(self):
        terminal = await Terminal()
        reader, writer = await asyncio.open_connection('127.0.0.1', 8000)
        await self.init_account(writer)
        tasks = (
            asyncio.create_task(self._typing(terminal, writer)),
            asyncio.create_task(self._reading(terminal, reader)),
        )
        await asyncio.wait(tasks, return_when='FIRST_COMPLETED')
