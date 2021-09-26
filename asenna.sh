curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/evdev.xml
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/fi
curl https://raw.githubusercontent.com/avserkkila/suomalainen-das/master/keyboard

mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml
mv fi /usr/share/X11/xkb/symbols/fi
mv keyboard /etc/default/keyboard
