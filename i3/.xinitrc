#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
feh --bg-scale /home/Downloads/space-shuttle-16092-1920x1080.jpg
[[ -f ~/.Xresources ]] && xrdb  -merge ~/.Xresources 
exec i3
feh --bg-scale /home/Downloads/space-shuttle-16092-1920x1080.jpg
[[ -f ~/.Xresources ]] && xrdb  -merge ~/.Xresources 
