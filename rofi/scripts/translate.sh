#!/usr/bin/env bash

HIST="${XDG_DATA_HOME:-~/.local/share}/rofi/rofitr_history"
mkdir -p "$(dirname "$HIST")"

# Translation mode state file
MODE_FILE="/tmp/rofi_translate_mode"
[ ! -f "$MODE_FILE" ] && echo "en->tr" > "$MODE_FILE"
CURRENT_MODE=$(cat "$MODE_FILE")

# Function to switch keyboard layout
switch_layout() {
    local lang="$1"
    case "$lang" in
        "tr")
            setxkbmap tr
            ;;
        "en"|*)
            setxkbmap us
            ;;
    esac
    setxkbmap -option caps:ctrl_modifier
}

# Function to restore original layout
restore_layout() {
    setxkbmap -layout us,tr -option caps:ctrl_modifier,grp:win_space_toggle
}

# Ensure layout is restored on exit
trap restore_layout EXIT

format_result() {
    local result="$1"
    echo -en "\x00message\x1f<span face='mono' size='medium'><b>$result</b></span>\n"
}

if [ -z "$ROFI_RETV" ]; then
    # Initial call - show prompt and help
    echo -en "\x00prompt\x1f[$CURRENT_MODE]\n"
    echo -en "\x00message\x1f<span>Current mode: <b>$CURRENT_MODE</b>
<b>Tab</b> to switch mode
<b>text</b> to translate
<b>!h</b> for history
<b>?</b> for help</span>\n"
    [ -f "$HIST" ] && tac "$HIST"
    exit 0
fi

case "$ROFI_RETV" in
    0)  # Initial input
        ;;
    1|2)  # Enter pressed on text input or history item
        input="$@"
        case "$input" in
            "?")
                echo -en "\x00prompt\x1f help\n"
                echo -en "\x00message\x1f<span><b>Usage:</b>
- Press <b>Tab</b> to switch between en->tr and tr->en
- Type text to translate according to current mode
- Use <b>!h</b> to view history
- Press ESC to exit</span>\n"
                ;;
            "!h")
                echo -en "\x00prompt\x1f history\n"
                [ -f "$HIST" ] && tac "$HIST"
                ;;
            $'\t')  # Tab key pressed
                if [ "$CURRENT_MODE" = "en->tr" ]; then
                    echo "tr->en" > "$MODE_FILE"
                    switch_layout "tr"
                else
                    echo "en->tr" > "$MODE_FILE"
                    switch_layout "en"
                fi
                CURRENT_MODE=$(cat "$MODE_FILE")
                echo -en "\x00prompt\x1f[$CURRENT_MODE]\n"
                echo -en "\x00message\x1fSwitched to <b>$CURRENT_MODE</b> mode\n"
                ;;
            *)
                if [ -n "$input" ]; then
                    if [ "$CURRENT_MODE" = "en->tr" ]; then
                        switch_layout "en"
                        result=$(crow -e google -s en -t tr -- "$input")
                    else
                        switch_layout "tr"
                        result=$(crow -e google -s tr -t en -- "$input")
                    fi
                    [ -n "$result" ] && [ "$ROFI_RETV" -eq 1 ] && echo "$input" >> "$HIST"
                    format_result "$result"
                fi
                ;;
        esac
        ;;
esac
