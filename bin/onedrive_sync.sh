#!/usr/bin/env bash

# Check if another instance of this script is running
for pid in $(pgrep -f "onedrive --monitor"); do
    if [ $pid != $$ ]; then
        notify-send "Warning" "[$(date)] : onedrive_sync.sh : Process is already running with PID $pid"
        exit 1
    fi
done

if [[ -x "$(which onedrive_sync.sh)" ]]; then
	onedrive --monitor
fi
