import asyncio
import util
import logging


async def echo(socket, event_loop):
    try:
        while data := await event_loop.sock_recv(socket, 50):
            if data == b'boom\r\n':
                raise Exception('Unexpected error')
            await event_loop.sock_sendall(socket, data)
    except Exception as e:
        logging.exception(e)
    finally:
        socket.close()


async def listen_for_connections(server_socket, event_loop):
    while True:
        connection, address = await event_loop.sock_accept(server_socket)
        connection.setblocking(False)
        print(f'connected to {address}')
        asyncio.create_task(echo(connection, event_loop))


async def main():
    await listen_for_connections(
        util.get_listening_server_socket(),
        asyncio.get_event_loop(),
    )


asyncio.run(main())
