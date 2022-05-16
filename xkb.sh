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

tied=/usr/share/X11/xkb/symbols/fi
if ! grep -q 'xkb_symbols "das2" {' ${tied}; then
    cat das2 >> $tied 2>/dev/null || curl ${url}/das2 >> $tied
fi

[ -f keyboard ] && cp keyboard /etc/default/keyboard || curl ${url}/keyboard > /etc/default/keyboard

if command -v setxkbmap >/dev/null; then
    setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,ruu,extended -option grp:shift_caps_toggle
fi
if command -v localectl >/dev/null; then
    localectl --no-convert set-x11-keymap fi,fi,ru,gr pc105 das2,nodeadkeys,ruu,extended grp:shift_caps_toggle
fi

#Osa Wayland-ympäristöistä käyttää ympäristömuuttujia näppäimistöasettelun määrittelyyn
aseta() {
    if grep -q $1 /etc/environment; then
	sed -i "s/^$1=[^#]*/$1=$2/" /etc/environment
    else
	echo "$1=$2" >> /etc/environment
    fi
}

aseta 'XKB_DEFAULT_MODEL' 'pc105'
aseta 'XKB_DEFAULT_LAYOUT' 'fi,fi,ru,gr'
aseta 'XKB_DEFAULT_VARIANT' 'das2,nodeadkeys,ruu,extended'
aseta 'XKB_DEFAULT_OPTIONS' 'grp:shift_caps_toggle'
