#!/bin/bash
# notify when keyboard layout changed

# get the current keymap using hyprctl
kbdName="at-translated-set-2-keyboard"
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
keymap=${keymap//English (US)/🇺🇸 English}
keymap=${keymap//English (Dvorak)/🇺🇸 Dvorak}
keymap=${keymap//Spanish (Latin American)/🇲🇽 Spanish}
keymap=${keymap//Russian/🇷🇺 Russian}
keymap=${keymap//Greek/🇬🇷 Greek}
keymap=${keymap//Arabic (Egypt)/🇪🇬 Arabic}
keymap=${keymap//Hebrew/🇮🇱 Hebrew}

newTxt="${keymap}"
notify-send "$newTxt"
#echo $newTxt
