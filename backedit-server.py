#!/usr/bin/env python3

import base64
import datetime
import http.server
import json
import os
import socket
import subprocess
import traceback
import urllib.parse
from pathlib import Path


PORT = 8765
ADDRESS = ""

SECRET_LENGTH = 32
SECRET_EXPIRES_AT = None
SECRET_KEY = None
BACKEDIT_REMOTE_CONF = Path.home() / "config/remoteconfig/backedit.conf"

class BadInput(BaseException):
    pass

class HTTPRequestHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        make_backedit_remote_conf()
        # print(self.path)
        # print(self.headers)
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        response = {"status": "OK"}
        self.wfile.write(json.dumps(response).encode("utf-8"))
        return


    def do_POST(self):
        # print(self.path)
        # print(self.headers)
        content_length = int(self.headers["Content-Length"])
        content = self.rfile.read(content_length).decode("utf-8")
        try:
            handle(content)
        except BadInput as e:
            traceback.print_exc()
            self.send_error(400, explain=str(e))
        except Exception as e:
            traceback.print_exc()
            self.send_error(500, explain=str(e))
        else:
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            response = {"status": "OK", "port": PORT, "ADDRESS": ADDRESS}
            self.wfile.write(json.dumps(response).encode("utf-8"))

def handle(raw_content):
    print(raw_content)
    request = json.loads(raw_content)
    for part in ["sudo", "user", "host", "secret", "path"]:
        if part not in request:
            raise BadInput("Bad input")

    for char in ":/@ \n":
        for var in [request["sudo"], request["user"], request["host"]]:
            if char in  var:
                raise BadInput("Bad input")
    user = "spi"
    if request["sudo"] in ["yes", "y", "sudo"]:
        extend = "|sudo:{host}".format(host=request["host"])
    else:
        extend = ""
    lisp = """(select-window (display-buffer (find-file-noselect "/{method}:{user}@{host}{extend}:{path}")))""".format(method="ssh", user=request["user"], host=request["host"], path=request["path"], extend=extend)
    command = ["emacsclient", "-e", lisp, "-e", "(x-focus-frame (selected-frame))"]
    subprocess.run(["bspc", "config", "ignore_ewmh_focus", "false"])
    subprocess.run(command)
    subprocess.run(["bspc", "config", "ignore_ewmh_focus", "true"])

def update_secret():
    global SECRET_EXPIRES_AT
    global SECRET_KEY
    now = datetime.datetime.utcnow()
    if (not SECRET_EXPIRES_AT or
        now > SECRET_EXPIRES_AT):
        tomorrow = now + datetime.timedelta(days=1)
        SECRET_EXPIRES_AT = tomorrow.replace(hour=3, minute=0, second=0, microsecond=0)
        SECRET_KEY = base64.urlsafe_b64encode(os.urandom(SECRET_LENGTH)).rstrip(b"=").decode("ascii")
    return SECRET_KEY

def make_backedit_remote_conf():
    update_secret()
    conf = """
BACKEDIT_SERVER="{}"
BACKEDIT_PORT="{}"
BACKEDIT_SECRET="{}"
    """.strip().format(get_ip(), PORT, SECRET_KEY)
    BACKEDIT_REMOTE_CONF.write_text(conf)

def get_ip():
    # https://stackoverflow.com/questions/166506/finding-local-ip-addresses-using-pythons-stdlib
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # doesn't have to be reachable
        s.connect(("10.255.255.255", 1))
        ip = s.getsockname()[0]
    except Exception:
        ip = "127.0.0.1"
    finally:
        s.close()
    return ip

def main():
    update_secret()
    make_backedit_remote_conf()
    server = http.server.HTTPServer((ADDRESS, PORT), HTTPRequestHandler)
    server.serve_forever()

if __name__ == "__main__":
    main()
