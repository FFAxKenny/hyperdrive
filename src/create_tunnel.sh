# This command opens a background tunnel to the a hostname
# and redirects remote requests to the same port on the local machine
# (the machine that you are initiating the session from) 
#
# remote-machine should be an ssh alias defined in .ssh/config or hostname 
# defined in the hosts file
#

ssh_alias=$1
port=$2
ssh -L $port:localhost:$port -N -f $ssh_alias -c arcfour,blowfish-cbc -XC
