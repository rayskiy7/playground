import util
import threading as th


def echo(connection):
    while True:
        data = connection.recv(1024)
        print(f'Recieved! Send: {data}')
        connection.sendall(data)


with util.get_listening_server_socket(blocking=True) as server_socket:
    while True:
        new_connection, connection_address = server_socket.accept()
        th.Thread(target=echo, args=(new_connection, )).start()
