#!/bin/bash
# A short script to list vnc sessions on a machine
# Courtesy of Todd Yamakawa.
alias vnc 'ps -ef | awk '"'"'{print $11, $1}'"'"' | grep `hostname` | sed "s/`hostname`://g" | sort -n'
