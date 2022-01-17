#!/bin/sh
if ! [ -f das2.xml ]; then
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/das2.xml > das2.xml
fi

if ! grep -q '<name>das2</name>' /usr/share/X11/xkb/rules/evdev.xml; then
    ed -s /usr/share/X11/xkb/rules/evdev.xml<<EOF
/<shortDescription>fi<\/shortDescription>/
/<\/variantList>/
-r das2.xml
w
q
EOF
fi

if ! [ -f das2 ]; then
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/das2 > das2
fi
if ! grep -q 'xkb_symbols "das2" {' /usr/share/X11/xkb/symbols/fi; then
    cat das2 >> /usr/share/X11/xkb/symbols/fi
fi

if [ -f keyboard ]; then
    cp keyboard /etc/default/keyboard
else
    curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/keyboard > /etc/default/keyboard
fi

setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,dos,extended -option grp:shift_caps_toggle
localectl --no-convert set-x11-keymap fi,fi,ru,gr pc105 das2,nodeadkeys,dos,extended grp:shift_caps_toggle
