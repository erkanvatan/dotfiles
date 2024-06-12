#/usr/bin/env bash
# This script launches swift-map and remaps keys in keyboard.
#
# Put this script in /etc/apm/scripts.d and create a symlink to it
# in /etc/apm/resume.d using:
#   sudo ln -s  /etc/apm/scripts.d/launch_swiftmap.sh /etc/apm/resume.d/launch_swiftmap.sh

if [ -d "$HOME/programs/swift-map" ]; then
    pkill -f ".*swift-map/mainloop.py"
    # TODO: change keyboard layout to refrest available keys
    exec $HOME/programs/swift-map/mainloop.py nosleep
fi
