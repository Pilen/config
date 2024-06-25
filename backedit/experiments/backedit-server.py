import http.server
import socketserver
import time
from pathlib import Path

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        print("Got connection")
        content_length = int(self.headers["Content-Length"] or 0)
        print(content_length)
        content = self.rfile.read(content_length)
        print(content)
        print("sleeping")
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Hello, World!")

class Server(socketserver.UnixStreamServer):
    def get_request(self):
        request, client_address = super().get_request()
        return (request, ["local", 0])

def main():
    socket_path = Path("/tmp/backedit.socket")
    socket_path.unlink()
    server = Server(str(socket_path), MyHandler)
    server.serve_forever()

if __name__ == "__main__":
    main()
