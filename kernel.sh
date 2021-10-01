mkdir -p /usr/src/linux/drivers/char/
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/fi-das.map > /usr/src/linux/drivers/char/defkeymap.map
cp /usr/src/linux/drivers/char/defkeymap.map /usr/share/kbd/keymaps/fi-das.map
#echo KEYMAP=fi-das > /etc/vconsole.conf
