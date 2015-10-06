#!/bin/sh
#set -e
export DISPLAY=:0
focused_window=$(xdotool getwindowfocus)
xdotool search --name 'Hello React!' windowactivate xdotool key super+r
xdotool windowactivate $focused_window
