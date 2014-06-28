hyperdrive
===================

A collection of scripts to aid with a workflow based around
resources behind firewalls, but with SSH access. Future 
improvements including a single interface to come later. 

### Motivation

Many times it might not be possible to completely open up 
firewalls, either for security or access purposes. In the case
where a full fledged VPN may be too much setup, a SSH tunnel
based workflow might be a great solution. Especially for VNC
sessions, SSH tunnels provide a lightweight and relatively 
pain-free way to access remote resources. 

### An example

Take the example where you have a production server, which contains
a resource which can only be accessed by a web GUI. Normally
if you have physical access to box, you could load your
favorite window manager, and then go ahead and type in 
`http://localhost:port` into your browser.

If you're on a remote machine, this gets a little harder, but you 
_could_ set your machine to accept remote requests for this port. 
This, however, opens up another area for an external attack on your
machine.


## Requirements

* Cygwin (if running Windows)
* Tightvnc (if running windows)
* Vncviewer
* Python

