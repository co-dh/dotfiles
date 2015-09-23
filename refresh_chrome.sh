#!/bin/sh
#set -e
focused_window=$(xdotool getwindowfocus)
xdotool windowfocus `cat ~/selectwindow`
xdotool key --window `cat ~/selectwindow` F5
xdotool windowfocus $focused_window
