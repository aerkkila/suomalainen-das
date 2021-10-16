curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/evdev.xml > /usr/share/X11/xkb/rules/evdev.xml
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/fi > /usr/share/X11/xkb/symbols/fi
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/keyboard > /etc/default/keyboard
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/00-keyboard.conf > /etc/X11/xorg.conf.d/00-keyboard.conf
