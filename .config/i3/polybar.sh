#!/usr/bin/env sh

_CONNECTED_SCREENS=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')

if [[ $_CONNECTED_SCREENS =~ ^HDMI1$ ]]; then
    export MONITOR=HDMI1
elif [[ $_CONNECTED_SCREENS =~ ^DP1-1$ ]]; then
    export MONITOR=DP1-1
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar top &
polybar bottom &
