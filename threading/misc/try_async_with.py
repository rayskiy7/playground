import util
import asyncio


class ConnectedSocket:
    def __init__(self, server_socket):
        self._connection = None
        self._server_socket = server_socket

    async def __aenter__(self):
        loop = asyncio.get_event_loop()
        self._connection, self._address = await loop.sock_accept(self._server_socket)
        print(f'Connected to {self._address}')
        return self._connection

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        self._connection.close()
        print(f'connection with {self._address} closed')


async def main():
    server_socket = util.get_listening_server_socket()
    loop = asyncio.get_event_loop()
    async with ConnectedSocket(server_socket) as connection:
        data = await loop.sock_recv(connection, 50)
        print(data)


asyncio.run(main())
