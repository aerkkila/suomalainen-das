#!/bin/sh
url='https://raw.githubusercontent.com/aerkkila/suomalainen-das/master'

if ! grep -q '<name>das2</name>' /usr/share/X11/xkb/rules/evdev.xml; then
    [ -f das2.xml ] || curl ${url}/das2.xml > das2.xml
    ed -s /usr/share/X11/xkb/rules/evdev.xml<<EOF
/<shortDescription>fi<\/shortDescription>/
/<\/variantList>/
-r das2.xml
w
q
EOF
fi

if ! grep -q 'xkb_symbols "das2" {' /usr/share/X11/xkb/symbols/fi; then
    tied='/usr/share/X11/xkb/symbols/fi'
    [ -f das2 ] && cat das2 >> ${tied} || curl ${url}/das2 >> ${tied}
fi

setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,dos,extended -option grp:shift_caps_toggle
localectl --no-convert set-x11-keymap fi,fi,ru,gr pc105 das2,nodeadkeys,dos,extended grp:shift_caps_toggle
