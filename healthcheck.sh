#!/bin/sh

# Check if the process is running
if ! pgrep -f "TwitchDropsMiner" > /dev/null; then
    echo "Process not running"
    exit 1
fi

# TODO: Check recent logs for Python errors

exit 0
