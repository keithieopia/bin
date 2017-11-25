#!/usr/bin/env python

import BaseHTTPServer, SimpleHTTPServer
server = BaseHTTPServer.HTTPServer(('',8080),SimpleHTTPServer.SimpleHTTPRequestHandler)
server.serve_forever()