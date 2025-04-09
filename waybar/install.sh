#!/bin/bash
# installs my waybar config
# by TesseractPi

echo This script will copy my waybar config to ~/.config/waybar and ~/.config/rofi. 
echo
echo If you don\'t want to install this, press Ctrl-C. You have five seconds. 
echo 5...
sleep 1
echo 4...
sleep 1
echo 3...
sleep 1
echo 2...
sleep 1
echo 1...
sleep 1
echo Commencing install...
cp -vrf waybar/* $HOME/.config/waybar
cp -vrf rofi/* $HOME/.config/rofi
