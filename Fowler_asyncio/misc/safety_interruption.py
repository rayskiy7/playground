import asyncio
import signal
import typing as tp
import util

tasks = []


async def echo(socket, event_loop):
    while data := await event_loop.sock_recv(socket, 50):
        await event_loop.sock_sendall(socket, data)


async def listen_for_connections(server_socket, event_loop):
    while True:
        connection, address = await event_loop.sock_accept(server_socket)
        connection.setblocking(False)
        print(f'connected to {address}')
        tasks.append(asyncio.create_task(echo(connection, event_loop)))


async def main():
    await listen_for_connections(
        util.get_listening_server_socket(),
        asyncio.get_event_loop(),
    )


class GracefulExit(SystemExit):
    pass


def shutdown():
    raise GracefulExit()


async def close_tasks():
    for task in tasks:
        awaited = asyncio.wait_for(task, timeout=2)
        print(f'Wait 2 second for task {awaited}')
        try:
            await awaited
        except asyncio.exceptions.TimeoutError:
            pass


loop: asyncio.AbstractEventLoop = asyncio.get_event_loop()
loop.add_signal_handler(signal.SIGINT, shutdown)
try:
    loop.run_until_complete(main())
except GracefulExit:
    loop.run_until_complete(close_tasks())
