#!/bin/sh
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/evdev.xml > /usr/share/X11/xkb/rules/evdev.xml
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/fi > /usr/share/X11/xkb/symbols/fi
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/keyboard > /etc/default/keyboard
setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,dos,extended -option grp:shift_caps_toggle
localectl --no-convert set-x11-keymap fi,fi,ru,gr pc105 das2,nodeadkeys,dos,extended grp:win_space_toggle
