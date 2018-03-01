#!/bin/bash

echo "install Dummy Ipam server..."

git clone https://github.com/gkatsaros/scripts.git

python scripts/dummy_ipam/ipam-dummy-server.py 8888
