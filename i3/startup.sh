#!/bin/bash

# Start Spotify in workspace 5
# i3-msg "workspace 5"
# flatpak run com.spotify.Client &

# Start Firefox in workspace 2
i3-msg "workspace 2"
i3-msg "exec firefox"

# Start Vivaldi in workspace 3
i3-msg "workspace 3"
i3-msg "exec vivaldi"

# Start kitty in workspace 1
i3-msg "workspace 1"
i3-msg "exec kitty -e ~/.local/bin/tmux-sessionizer ~/"

# Return to workspace 1 and run remind command
i3-msg "workspace 1"
sleep 2
tmux send-keys -t "tuna" "remind -c -m -w1,2,1 ~/.local/bin/assets/remind_birthdays.rem; birthday_cow" Enter
