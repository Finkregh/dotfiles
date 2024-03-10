#!/usr/bin/env bash

_CONNECTED_SCREENS=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')

if [[ $_CONNECTED_SCREENS = eDP1 ]]; then
    export POLYBAR_TRAY_POSITION_EXTERNAL=none
elif [[ $_CONNECTED_SCREENS =~ DP-1-1 ]]; then
    export MONITOR=DP-1-1
    export POLY_DPI=192
elif [[ $_CONNECTED_SCREENS =~ HDMI-1 ]]; then
    export MONITOR=HDMI-1
    export POLY_DPI=192
elif [[ $_CONNECTED_SCREENS =~ DP1 ]]; then
    export MONITOR=DP1
    export POLYBAR_TRAY_MAXSIZE=20
else
    export POLYBAR_TRAY_POSITION_EXTERNAL=none
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar top &
polybar top-laptop &
polybar bottom &
polybar bottom-laptop &
