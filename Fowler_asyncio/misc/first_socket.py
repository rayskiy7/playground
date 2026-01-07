from util import get_listening_server_socket

server_socket = get_listening_server_socket()

connections = []

try:
    while True:
        connection, client_address = server_socket.accept()  # wait for a new connection
        connection.setblocking(False)
        print(f'connected to {client_address}')
        connections.append(connection)

        for connection in connections:
            buffer = bytearray()
            last = bytearray(b'\r\n')

            while buffer[-2:] != last:
                data = connection.recv(2)
                if not data:
                    break
                else:
                    print (f'Recieved: {data}')
                    buffer.extend(data)

            print (f'All data: {buffer}')
            connection.sendall(buffer)

finally:
    server_socket.close()

    


# The problem with this approach is that sockets throw exceptions when there are no connections or data.
# We could ignore these exceptions, but then the CPU would spike to 100% handling exceptions in an infinite loop. Bad!
