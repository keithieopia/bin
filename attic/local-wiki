#!/bin/bash

php -S 127.0.0.1:8080 -t ~/projects/wiki &
PHP_PID=$!

firefox http://127.0.0.1:8080 &> /dev/null
kill -SIGINT "$PHP_PID"