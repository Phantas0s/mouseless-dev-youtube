#!/usr/bin/env bash

trap 'kill -- -$$' EXIT SIGINT ERR

echo "Running Server"
./super_server &

echo "Doing stuff using the server"
