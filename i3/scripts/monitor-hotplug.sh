#!/bin/bash
# Save as ~/.config/i3/scripts/monitor-hotplug.sh

export DISPLAY=:0
export XAUTHORITY=/home/YOUR_USERNAME/.Xauthority

function connect() {
    xrandr --output HDMI-1 --auto --right-of eDP-1
}

function disconnect() {
    xrandr --output HDMI-1 --off
}

# Check if HDMI is connected
if xrandr | grep "HDMI-1 connected"; then
    connect
else
    disconnect
fi
