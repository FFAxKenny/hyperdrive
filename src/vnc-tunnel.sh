#!/bin/bash

# =======================================================
#
# create_vnc.sh
# 
# This script opens up an SSH tunnel and then connects 
# to the vnc session on that port.
#
#
# =======================================================

ssh_alias=$1
screen=$2
port=$((5900+$screen))
# ssh -L 5901:localhost:5901 -N -f rdr -c arcfour,blowfish-cbc -XC
./create_tunnel.sh $ssh_alias $port
vncviewer localhost:$screen
