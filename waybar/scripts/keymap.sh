#!/bin/bash
# notify when keyboard layout changed

# get the current keymap using hyprctl
kbdName="at-translated-set-2-keyboard"
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
keymap=${keymap//English (US)/🇺🇸}
keymap=${keymap//English (Dvorak)/🇺🇸 DV}
keymap=${keymap//Spanish (Latin American)/🇲🇽}
keymap=${keymap//Russian/🇷🇺}
keymap=${keymap//Greek/🇬🇷}
keymap=${keymap//Arabic (Egypt)/🇪🇬}
keymap=${keymap//Hebrew/🇮🇱}

newTxt="${keymap}"
#echo $newTxt
case "${1}" in
    c) change ;;
    d) display ;;
esac

display () {
    echo "{\"text\": \"${newTxt}\", \"tooltip\": \"$tooltip\"}"
}
