#!/bin/bash

# Get process id (one of them)
PID=$(pidof "$1" | cut -d " " -f 1)

# Ignore if the program is closed
[ -z $PID ] && exit

# Copy WINE environment variables
export $(xargs -0 -L1 -a /proc/$PID/environ | grep WINE | grep -Ev "LOAD|SERVER")

# Get the executable path
EXEC=$(cat /proc/$PID/cmdline | cut -d '' -f1 | xargs -0 ${WINE}path 2>/dev/null)

${WINE}console "$EXEC" "$2"
