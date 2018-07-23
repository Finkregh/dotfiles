#!/usr/bin/env sh

_CONNECTED_SCREENS=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')

if [[ $_CONNECTED_SCREENS =~ HDMI2 ]]; then
    export MONITOR=HDMI2
    export POLY_DPI=96
    export POLYBAR_TRAY_POSITION_EXTERNAL=left
elif [[ $_CONNECTED_SCREENS =~ DP1 ]]; then
    export MONITOR=DP1
    export POLYBAR_TRAY_POSITION_EXTERNAL=left
    export POLYBAR_TRAY_MAXSIZE=20
else
    export POLYBAR_TRAY_POSITION_EXTERNAL=none
    export POLYBAR_TRAY_POSITION_LAPTOP=left
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
