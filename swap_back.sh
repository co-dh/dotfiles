#!/bin/sh
xmodmap -e "clear control"
xmodmap -e "clear mod1"
xmodmap -e "add mod1 = Alt_L Alt_R"
xmodmap -e "add control = Control_L Control_R"

