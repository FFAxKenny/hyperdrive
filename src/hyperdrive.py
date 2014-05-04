#!/usr/bin/env python
import argparse
import readline

parser = argparse.ArgumentParser(description='Hyperdrive - a ssh based workflow assistant.')
parser.add_argument('options', metavar="O", help='the option we run the program with')
option = parser.parse_args().options

if( option == 'create'):
    print "Lets create a tunnel together!"
elif( option == 'vnc'):
    print "Lets VNC somewhere together!"
elif( option == 'rdp'):
    print "Lets rdp somewhere together!"
elif( option == 'cleanup'):
    print "Cleanup."
else:
    print "Error: Invalid command." 

