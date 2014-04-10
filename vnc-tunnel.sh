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
# ssh -L 5901:localhost:5901 -N -f rdr -c arcfour,blowfish-cbc -XC
./create_tunnel.sh $ssh_alias
vncviewer localhost:1



