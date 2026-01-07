import selectors
import socket
import typing as tp
from util import get_listening_server_socket

selector = selectors.DefaultSelector()
server_socket = get_listening_server_socket()
selector.register(server_socket, selectors.EVENT_READ)

while True:
    events: tp.List[tp.Tuple[selectors.SelectorKey, int]] = selector.select(timeout=5)

    if len(events) == 0:
        print('There are no events yet! Waiting for a second...')

    for event, _ in events:
        event_socket = event.fileobj

        if event_socket == server_socket:
            connection, address = server_socket.accept()
            connection.setblocking(False)
            print(f'connected to {address}')
            selector.register(connection, selectors.EVENT_READ)
        else:
            data = event_socket.recv(50)
            print(f'Recieved data: {data}')
            event_socket.send(data)

