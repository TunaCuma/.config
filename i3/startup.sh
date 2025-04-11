#!/bin/bash
# Start Firefox in workspace 2
i3-msg "workspace 2"
i3-msg "exec firefox"

# Start Vivaldi in workspace 3
i3-msg "workspace 3"
i3-msg "exec vivaldi"

# Start kitty with tmuxp in workspace 1
i3-msg "workspace 1"
i3-msg "exec kitty -e bash -c 'tmuxp load -y home > /dev/null 2>&1'"

# Return to workspace 1
i3-msg "workspace 1"
