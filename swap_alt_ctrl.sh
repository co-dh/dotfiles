#!/bin/sh
xmodmap -e "clear control"
xmodmap -e "clear mod1"
xmodmap -e "add control = Alt_L Alt_R"
xmodmap -e "add mod1 = Control_L Control_R"

