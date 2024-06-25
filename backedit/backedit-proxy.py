import socket
import sys
from pathlib import Path
SOCKET_PATH = Path("/tmp/backedit.socket")

def main():
    SOCKET_PATH.unlink(missing_ok=True)
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as server:
        server.bind(str(SOCKET_PATH))
        server.listen()
        while True:
            conn, addr = server.accept()
            conn.settimeout(1)
            try:
                buffer = []
                while True:
                    data = conn.recv(4096)
                    if data == b"":
                        break
                    buffer.append(data)
                message = (b"".join(buffer)).decode("utf-8")
                print(message, flush=True)
            except TimeoutError:
                print("Connection timed out", file=sys.stderr)


if __name__ == "__main__":
    main()
