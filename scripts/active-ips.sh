#!/bin/bash

# Define the subnet
SUBNET="10.0.0.0"

echo "Scanning the network: ${SUBNET}0/24"
echo "Active IPs in the network:"

# Scan the subnet for active IPs
for i in {1..254}; do
    IP="${SUBNET}${i}"
    ping -c 1 -W 1 $IP &> /dev/null && echo "$IP is active" &
done

wait
echo "Scan complete."