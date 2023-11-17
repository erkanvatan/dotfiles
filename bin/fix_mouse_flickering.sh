#/usr/bin/env bash
# Fix mouse flickering that occurs when you scale the second monitor in X11.

# Scale the second monitor
xrandr --output HDMI-1 --scale 0.7x0.7
# Fix mouse flickering on the primary monitor
xrandr --output eDP-1 --scale 0.9999x0.9999
