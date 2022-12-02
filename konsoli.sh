#!/bin/sh
kansio=/usr/src/linux/drivers/char
vaihtoehdot='/usr/share/kbd/keymaps/ /usr/share/keymaps/'
asettelu=

asenna() {
    asettelu=$1
    map="$1.map"
    [ -d /usr/src/linux/ ] && mkdir -p $kansio
    [ -f $map ] || curl https://raw.githubusercontent.com/aerkkila/suomalainen-das/master/$map > $map
    for dir in $vaihtoehdot; do
	if [ -d $dir ]; then
	    cp $map $dir
	    break
	fi
    done
    [ -d $kansio ] && [ "$2" != "tmp" ] && cp $map ${kansio}/defkeymap.map
}

asenna 'fi-das' $1
loadkeys fi-das || {
    echo 'yritetään fi-das-1'
    asenna 'fi-das-1' $1
    loadkeys fi-das-1 && echo onnistui || echo ei onnistunut
}

[ "$1" = "tmp" ] && exit

if [ -f /etc/vconsole.conf ]; then
    if grep -q 'KEYMAP=' /etc/vconsole.conf; then
	sed -i "s|.*KEYMAP=[^#]*|KEYMAP=$asettelu|" /etc/vconsole.conf
    else
	echo KEYMAP=$asettelu >> /etc/vconsole.conf
    fi
else
    echo KEYMAP=$asettelu > /etc/vconsole.conf
fi
