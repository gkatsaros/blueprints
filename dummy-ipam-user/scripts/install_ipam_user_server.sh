#!/bin/bash

NAME="git"
LOCK="/tmp/lockaptget"

while true; do
  if mkdir "${LOCK}" &>/dev/null; then
    echo "$NAME take apt lock"
    break;
  fi
  echo "$NAME waiting apt lock to be released..."
  sleep 0.5
done

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
  echo "$NAME waiting for other software managers to finish..."
  sleep 0.5
done

sudo rm -f /var/lib/dpkg/lock
sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})
sudo apt-get -y -q install git || exit ${1}

rm -rf "${LOCK}"
echo "$NAME released apt lock"

echo "install Dummy Ipam server..."

git clone https://github.com/gkatsaros/scripts.git

ip=`cat /opt/ipam_ip`

python scripts/dummy-ipam-user/ipam-user-server.py -ip $ip &> /dev/null &
