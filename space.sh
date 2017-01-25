#!/bin/bash
spare_modifier="Hyper_L"
xmodmap -e "keycode 65 = $spare_modifier"
xmodmap -e "remove mod4 = $spare_modifier"
xmodmap -e "add Control = $spare_modifier"
xmodmap -e "keycode 255 = space"
xcape -e "$spare_modifier=space;Alt_L=Escape;Alt_R=Tab"


