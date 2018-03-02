#!/bin/bash -e
echo "exporting IPAM IP address to file"

echo $IPAM_IP > /opt/ipam_ip
