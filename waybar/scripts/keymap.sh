#!/bin/bash

# get the current keymap using hyprctl
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
keymapSymbol=$(echo "$keymap" | perl -pe 's/English \(US\)/en/g' | perl -pe 's/Spanish \(Latin American\)/es/g'| perl -pe 's/Spanish/es/g')

echo " ${keymapSymbol}"
