#!/bin/sh
if [ -f evdev.xml ]; then
    cp evdev.xml /usr/share/X11/xkb/rules/evdev.xml
else
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/evdev.xml > /usr/share/X11/xkb/rules/evdev.xml
fi

if [ -f fi ]; then
    cp fi /usr/share/X11/xkb/symbols/fi
else
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/fi > /usr/share/X11/xkb/symbols/fi
fi

if [ -f keyboard ]; then
    cp keyboard /etc/default/keyboard
else
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/keyboard > /etc/default/keyboard
fi
setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,dos,extended -option grp:shift_caps_toggle
localectl --no-convert set-x11-keymap fi,fi,ru,gr pc105 das2,nodeadkeys,dos,extended grp:shift_caps_toggle
