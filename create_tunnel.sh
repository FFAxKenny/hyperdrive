# This command opens a background tunnel to the reis1remote hostname
# and redirects remote requests on the port 5901 to the local machine
# (the machine that you are initiating the session from) 
ssh -L 5901:localhost:5901 -N -f remote-machine -c arcfour,blowfish-cbc -XC
