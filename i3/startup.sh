
#!/bin/bash

# Start Obsidian in workspace 4 with a delay
# i3-msg "workspace 4"
# flatpak run md.obsidian.Obsidian &

i3-msg "workspace 5"
flatpak run com.spotify.Client &

# Start Firefox in workspace 2
i3-msg "workspace 2; exec firefox"

# Start Vivaldi in workspace 3
i3-msg "workspace 3; exec vivaldi"

# Start kitty in workspace 1
i3-msg "workspace 1; exec kitty -e ~/.local/bin/tmux-sessionizer ~/"
