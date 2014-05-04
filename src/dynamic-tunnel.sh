#!/bin/bash -e
browser="firefox"
ssh_alias=$1
port_number=$2

# Create the dynamic ssh tunnel
ssh -f -N -D 5050 $ssh_alias

# Wait for our tunnel to finish connecting
sleep 2

# Open firefox with an SSHProxy profile and open our URL
$browser -p "SSHProxy" -no-remote --url "localhost:8080" &
trap "ps aux | grep ssh | grep 5050 | awk '{print \$2}' | xargs kill" EXIT SIGINT SIGTERM
wait

