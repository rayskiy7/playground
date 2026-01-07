import socket

def get_listening_server_socket(blocking=False):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    server_address = ('127.0.0.1', 8000)
    server_socket.bind(server_address)  # now server socket have concrete address: 127.0.0.1:8000

    server_socket.listen()  # go to listening regime
    server_socket.setblocking(blocking)

    return server_socket
