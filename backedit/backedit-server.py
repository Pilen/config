#!/usr/bin/env python3

import queue
import re
import socket
import subprocess
import threading
import time
from pathlib import Path

SOCKET_PATH = Path("/tmp/backedit-server.socket")
SOCKET_SERVER = None
QUEUE = queue.SimpleQueue()

def run_socket_server():
    global SOCKET_SERVER
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as server:
        SOCKET_SERVER = server
        server.bind(str(SOCKET_PATH))
        server.listen()
        while True:
            conn, addr = server.accept()
            conn.settimeout(1)
            try:
                receive_socket_message(conn)
            except TimeoutError:
                print("Connection timed out")

def receive_socket_message(conn):
    buffer = []
    while True:
        data = conn.recv(4096)
        if data == b"":
            break
        buffer.append(data)
    message = (b"".join(buffer)).decode("utf-8")
    QUEUE.put((message, None))


class Connection(threading.Thread):
    def __init__(self, host):
        self.host = host
        self.process = None
        self.killed = False
        threading.Thread.__init__(self, daemon=True)
        # super().__init__(self)

    def run(self):
        while True:
            if self.killed:
                break
            self.process = subprocess.Popen(
                # ["bash", "-c", "echo 'TEST a'; sleep 10; echo 'TEST b'"],
                # ["python3", "/config/backedit/backedit-proxy.py"],
                ["ssh", self.host, "python3", "~/remoteconfig/backedit-proxy.py"],
                stdin = subprocess.PIPE,
                stdout = subprocess.PIPE,
                universal_newlines=True)
            print("Connected to", self.host)
            # Note, dont use stdout.readlines() as that will block untill completion
            while True:
                line = self.process.stdout.readline()
                if line == "":
                    break
                line = line[:-1] # Strip newline
                QUEUE.put((line, self.host))
            self.killed = True

    def stop(self):
        self.killed = True
        self.process.kill()



def loop():
    connections = {}
    while True:
        message, host = QUEUE.get()
        try:
            handle(message, host, connections)
        except Exception as e:
            print(e)
        for host in connections.keys():
            if not connections[host].is_alive:
                connections.pop(host)

def handle(message, host, connections):
    command, arg = message.split(" ", 1)
    if command == "CONNECT":
        host = arg
        if host in connections:
            return
        validate_host(host)
        connection = Connection(arg)
        connections[host] = connection
        connection.start()
    elif command == "OPEN":
        if host is None:
            print("Open via local socket ignored")
            return
        how, path = arg.split(" ", 1)
        validate_host(host)
        validate_path(path)
        open_in_emacs(how, host, path)
    elif command == "TEST":
        print("Test", arg)
    else:
        print("Unknown command:", command)

def open_in_emacs(how, host, path):
    if how == "sudo":
        extend = "|sudo:"
    else:
        extend = ""
    lisp = f'(select-window (display-buffer (find-file-noselect "/ssh:{host}{extend}:{path}")))'
    command = ["emacsclient", "-e", lisp, "-e", "(x-focus-frame (selected-frame))"]
    print(command)
    # subprocess.run(["bspc", "config", "ignore_ewmh_focus", "false"])
    subprocess.run(command)
    # subprocess.run(["bspc", "config", "ignore_ewmh_focus", "true"])

def validate_host(host):
    assert re.fullmatch("[-a-zA-Z0-9._:@]+", host)
def validate_path(path):
    assert not re.search("""['"\n\\\\]""", path)

def main():
    try:
        SOCKET_PATH.unlink(missing_ok=True)
        socket_server = threading.Thread(target = run_socket_server, daemon=True)
        socket_server.start()
        print("Started")
        loop()
    except KeyboardInterrupt:
        SOCKET_SERVER.close()





if __name__ == "__main__":
    main()
