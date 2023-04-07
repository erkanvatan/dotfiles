#!/usr/bin/env bash
if ! [[ -d '/home/arensonz/Pictures/Screenshots' ]]; then
    mkdir -p /home/arensonz/Pictures/Screenshots
    
fi
gnome-screenshot  -w -B -f /home/arensonz/Pictures/Screenshots/$(date +"%Y-%m-%d_%H-%M-%S")_screenshot.png
