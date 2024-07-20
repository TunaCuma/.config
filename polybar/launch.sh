#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar on each monitor
echo "Launching Polybar on default monitor"
  polybar --reload example >> /tmp/polybar_default.log 2>&1 &


