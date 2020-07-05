import socket
import sqlite3

host = '127.0.0.1'
port = 65535
flag = 0
id = 0
sqldata = []

while True:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.bind((host, port))
        sock.listen()
        conn, addr = sock.accept()
        with conn:
            print('Connected by', addr)
            while True:
                data = conn.recv(1024)
                if data.decode('UTF-8') == 'break':
                    flag = 1
                if not data:
                    break
                conn.sendall(data.upper())

                id += 1
                sqldata.append((id, addr[0], addr[1], data.decode('cp1251'), data.upper().decode('cp1251')))

    if flag == 1:
        conn.close()
        sock.close()

        # Запись в SQL
        db_conn = sqlite3.connect('socket_db.sql')
        cursor = db_conn.cursor()
        cursor.execute("""DROP TABLE IF EXISTS sockets""")
        cursor.execute("""CREATE TABLE sockets (id, host, port, input, output)""")
        cursor.executemany("""INSERT INTO sockets VALUES (?,?,?,?,?)""", sqldata)
        db_conn.commit()

        break
