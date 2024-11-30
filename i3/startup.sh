
#!/bin/bash

# Start Obsidian in workspace 4 with a delay
# i3-msg "workspace 4"
# flatpak run md.obsidian.Obsidian &

i3-msg "workspace 5"
flatpak run com.spotify.Client &

# Open timetable png in workspace 4 with feh
i3-msg "workspace 4; exec feh ~/personal/haftalik.png"

# Start Firefox in workspace 2
i3-msg "workspace 2; exec firefox"

# Start Vivaldi in workspace 3
i3-msg "workspace 3; exec vivaldi"

# Start kitty in workspace 1
i3-msg "workspace 1; exec kitty -e ~/.local/bin/tmux-sessionizer ~/"

# i3-msg "workspace 6; exec tmux new-session -ds timer_session 'python3 ~/personal/python/pomodoro/main.py'"

i3-msg "workspace 1"

sleep 2

tmux send-keys -t "tuna" "remind -c -m -w1,2,1 ~/.local/bin/assets/remind_birthdays.rem; birthday_cow" Enter
