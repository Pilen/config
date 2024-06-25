import socket
import time

def main():
    content = "Hej med dig".encode("utf-8")
    content_length = len(content)
    message = b"".join([
        b"GET /connect HTTP/1.1\r\n",
        b"Host: backedit\r\n",
        b"Content-length: ", str(content_length).encode("utf-8"), b"\r\n",
        b"\r\n", # Two newlines in a row indicates end of headers
        content
    ])
    client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    client.settimeout(2)
    client.connect("/tmp/backedit.socket")
    client.sendall(message)
    buffer = []
    while True:
        response = client.recv(4096)
        if response == b'':
            break
        buffer.append(response)
    print((b"".join(buffer)).decode("utf-8"))
    # time.sleep(100)

if __name__ == "__main__":
    main()
