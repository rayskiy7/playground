import asyncio


class ChatServer:
    def __init__(self):
        self._clients = {}

    async def start(self):
        server = await asyncio.start_server(self.on_new_connection, '127.0.0.1', 8000)
        async with server:
            await server.serve_forever()

    async def on_new_connection(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        name = (await reader.readline()).decode().strip()
        self._clients[name] = writer
        await self._listen_for_messages(name, reader)

    async def _listen_for_messages(self, name, reader):
        try:
            while (message := await asyncio.wait_for(reader.readline(), timeout=60)) != b'':
                message = message.decode()
                await self.send_for_all(f'{name}: {message}')
        except Exception:
            print('error')
        finally:
            await self.remove_user(name)

    async def remove_user(self, name):
        self._clients[name].close()
        await self._clients[name].wait_closed()
        del self._clients[name]

    async def send_for_all(self, message: str):
        for writer in self._clients.values():
            writer.write(message.encode())
            await writer.drain()
