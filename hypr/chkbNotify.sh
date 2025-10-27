#!/bin/bash
# notify when keyboard layout changed

# get the current keymap using hyprctl
kbdName="at-translated-set-2-keyboard"
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
#keymap=$(hyprctl devices | grep -A 2 -i $kbdName | tail -n 1 | awk '{print $3}')

notify-send "  ${keymap}"
