import socket

host = '127.0.0.1'
port = 65535

while True:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.connect((host, port))
        send_data = input('You: ')
        sock.sendall(send_data.encode('UTF-8'))
        data = sock.recv(1024)

        print('Received:', repr(data.decode('UTF-8')))
    if send_data == 'break':
        sock.close()
        break

