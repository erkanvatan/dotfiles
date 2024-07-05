#!/usr/bin/env bash

# NOTE: GPU-accelerated terminal emulators open as blank screen in virtual machines
# (encountered in VirtualBox Ubuntu 22.04 machine). To solve this bug, run the program with:
#   LIBGL_ALWAYS_SOFTWARE=1 alacritty

if [ -x "$HOME/.cargo/bin/alacritty" ]; then
    LIBGL_ALWAYS_SOFTWARE=1 exec $HOME/.cargo/bin/alacritty 
fi
