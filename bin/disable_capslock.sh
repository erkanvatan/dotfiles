#!/usr/bin/env bash

if [[ -x "$(which setxkbmap)" ]]; then
    setxkbmap -option caps:none
fi
