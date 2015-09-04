#!/bin/sh
set -e
export DISPLAY=:0
focused_window=$(xdotool getwindowfocus)

xdotool search --onlyvisible --classname google-chrome windowfocus && sleep 0.2 && xdotool key "ctrl+r"

xdotool windowfocus $focused_window
