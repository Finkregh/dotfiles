#!/usr/bin/env bash

set -eu

_CONNECTED_SCREENS=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')

if [[ $_CONNECTED_SCREENS =~ HDMI1 ]]; then
    ~/.screenlayout/home.sh
elif [[ $_CONNECTED_SCREENS =~ DP1-1 ]]; then
    ~/.screenlayout/work.sh
fi
