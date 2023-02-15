#!/bin/sh
url='https://raw.githubusercontent.com/aerkkila/suomalainen-das/master'

if ! grep -q '<name>das2</name>' /usr/share/X11/xkb/rules/evdev.xml; then
    [ -f das2.xml ] || curl ${url}/das2.xml > das2.xml
    ed -s /usr/share/X11/xkb/rules/evdev.xml <<-EOF
	/<shortDescription>fi<\/shortDescription>/
	/<\/variantList>/
	i
	        <variant>
	          <configItem>
	            <name>das2</name>
	            <description>Finnish (DAS muokkauksin)</description>
	          </configItem>
	        </variant>
	.
	w
	q
EOF
fi

tied=/usr/share/X11/xkb/symbols/fi
[ -f das2 ] || curl ${url}/das2 > das2
if ! grep -q 'xkb_symbols "das2" {' ${tied}; then
    cat das2 >> $tied
else
    ed -s $tied >/dev/null <<-EOF
	/xkb_symbols "das2"
	-2
	.,/lopetadas2/d
	.r das2
	w
	q
EOF
fi

[ -f keyboard ] && cp keyboard /etc/default/keyboard || curl ${url}/keyboard > /etc/default/keyboard # Onko tämä turha?

# setxkbmap, jos ollaan xorg-ympäristössä
if ! env |grep -q WAYLAND_DISPLAY && env |grep -q DISPLAY; then
    if command -v setxkbmap >/dev/null; then
	setxkbmap -model pc105 -layout fi,fi,ru,gr -variant das2,nodeadkeys,ruu,extended -option grp:sclk_toggle,lv3:caps_switch,shift:both_capslock
    fi
fi

if [ -d /etc/X11/ ]; then
    mkdir -p /etc/X11/xorg.conf.d
    [ -f 90-oletus-xkb.conf ] && cp 90-oletus-xkb.conf /etc/X11/xorg.conf.d/ \
	    || curl ${url}/90-oletus-xkb.conf > /etc/X11/xorg.conf.d/
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
aseta 'XKB_DEFAULT_OPTIONS' 'grp:sclk_toggle,lv3:caps_switch,shift:both_capslock'
