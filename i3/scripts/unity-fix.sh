#!/bin/bash
win_id=$(xdotool getwindowfocus)
xdotool windowunmap "$win_id"
sleep 0.05
xdotool windowmap "$win_id"
