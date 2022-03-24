#!/bin/sh
mkdir -p /usr/src/linux/drivers/char/
if [ -f fi-das.map ]; then
    cp fi-das.map /usr/src/linux/drivers/char/defkeymap.map
    cp fi-das.map /usr/share/kbd/keymaps/fi-das.map
else
    curl https://raw.githubusercontent.com/aerkkila/suomalainen-das/master/fi-das.map > /usr/src/linux/drivers/char/defkeymap.map
    cp /usr/src/linux/drivers/char/defkeymap.map /usr/share/kbd/keymaps/fi-das.map
fi
loadkeys fi-das

if [ -f /etc/vconsole.conf ]; then
    if grep -q 'KEYMAP=' /etc/vconsole.conf; then
	sed -i 's|.*KEYMAP=[^#]*|KEYMAP=fi-das|' /etc/vconsole.conf
    else
	echo KEYMAP=fi-das >> /etc/vconsole.conf
    fi
else
    echo KEYMAP=fi-das > /etc/vconsole.conf
fi
