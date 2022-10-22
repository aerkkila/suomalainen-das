#!/bin/sh
kansio=/usr/src/linux/drivers/char

asenna() {
    [ -d /usr/src/linux/ ] && mkdir -p $kansio
    if [ -f $1 ]; then
	cp $1 /usr/share/kbd/keymaps/
	[ -d $kansio ] && cp $1 ${kansio}/defkeymap.map
    else
	curl https://raw.githubusercontent.com/aerkkila/suomalainen-das/master/$1 > /usr/share/kbd/keymaps
	[ -d $kansio ] && cp /usr/share/kbd/keymaps/$1 $kansio
    fi
}

asenna 'fi-das.map'
loadkeys fi-das || {
    echo 'yritetään fi-das-1'
    asenna 'fi-das-1.map'
    loadkeys fi-das-1 && echo onnistui || echo ei onnistunut
}

if [ -f /etc/vconsole.conf ]; then
    if grep -q 'KEYMAP=' /etc/vconsole.conf; then
	sed -i 's|.*KEYMAP=[^#]*|KEYMAP=fi-das|' /etc/vconsole.conf
    else
	echo KEYMAP=fi-das >> /etc/vconsole.conf
    fi
else
    echo KEYMAP=fi-das > /etc/vconsole.conf
fi
