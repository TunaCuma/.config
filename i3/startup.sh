
#!/bin/bash


# Start Telegram and Whatsie in workspace 3 with a delay
i3-msg "workspace 3"
flatpak run org.ferdium.Ferdium &

# Start Obsidian in workspace 4 with a delay
i3-msg "workspace 4"
flatpak run md.obsidian.Obsidian &

i3-msg "workspace 5; exec spotify"

# Start Firefox in workspace 2
i3-msg "workspace 2; exec firefox"

# Start kitty in workspace 1
i3-msg "workspace 1; exec kitty"
