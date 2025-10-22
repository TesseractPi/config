#!/bin/bash

# Print error message for invalid arguments
print_error() {
  cat <<"EOF"
Usage: ./keymap.sh <action>
Valid actions are:
    f -- <f>irst option
    s -- <s>econd option
EOF
}

# get the current keymap using hyprctl
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

#echo "{\"text\": \" ${keymap}\", \"tooltip\": \"Keymap: ${keymap}\"}"
echo " ${keymap}"
