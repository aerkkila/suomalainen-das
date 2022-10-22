#!/bin/sh
kansio=/usr/src/linux/drivers/char
asettelu=

asenna() {
    asettelu=$1
    map="$1.map"
    [ -d /usr/src/linux/ ] && mkdir -p $kansio
    if [ -f $map ]; then
	cp $map /usr/share/kbd/keymaps/
	[ -d $kansio ] && cp $map ${kansio}/defkeymap.map
    else
	curl https://raw.githubusercontent.com/aerkkila/suomalainen-das/master/$map > /usr/share/kbd/keymaps
	[ -d $kansio ] && cp /usr/share/kbd/keymaps/$map $kansio
    fi
}

asenna 'fi-das'
loadkeys fi-das || {
    echo 'yritetään fi-das-1'
    asenna 'fi-das-1'
    loadkeys fi-das-1 && echo onnistui || echo ei onnistunut
}

if [ -f /etc/vconsole.conf ]; then
    if grep -q 'KEYMAP=' /etc/vconsole.conf; then
	sed -i "s|.*KEYMAP=[^#]*|KEYMAP=$asettelu|" /etc/vconsole.conf
    else
	echo KEYMAP=$asettelu >> /etc/vconsole.conf
    fi
else
    echo KEYMAP=$asettelu > /etc/vconsole.conf
fi
