#!/bin/bash
# Define options
options="Power Off\nReboot\nExit i3"
# Show menu and get user choice
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")
case "$chosen" in
    "Power Off")
        i3-msg '[class=".*"] kill'
        sleep 0.5
        systemctl poweroff
        ;;
    "Reboot")
        i3-msg '[class=".*"] kill'
        sleep 0.5
        systemctl reboot
        ;;
    "Exit i3")
        i3-msg '[class=".*"] kill'
        sleep 0.5
        i3-msg exit
        ;;
esac
