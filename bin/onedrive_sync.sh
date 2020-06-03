#!/usr/bin/env bash

# Check if another instance of this script is running
for pid in $(pgrep -f "onedrive --monitor"); do
    if [ $pid != $$ ]; then
        notify-send "Warning" "[$(date)] : onedrive_sync.sh : Process is already running with PID $pid"
        exit 1
    fi  
done

# Check if log dir exists, if not create one
logdir="$HOME/log/onedrive"
if [[ ! -d "$logdir" ]]; then
	mkdir $logdir
fi

# if number of logs reaches 10, delete all logs
nlogs="$(\ls -l $logdir| wc -l)"
if [[ nlogs -ge 10 ]]; then
	rm $logdir/**
fi

if [[ -x "$(which onedrive_sync.sh)" ]]; then
	date="$(date)"
	onedrive --monitor > $logdir/"$date"
fi


