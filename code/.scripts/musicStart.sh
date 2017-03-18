#!/bin/sh

killall -q mpd

while pgrep -x mpd > /dev/null;
do
    sleep 1;
done

mpd ~/.config/mpd/mpd.conf
vmhgfs-fuse -o allow_other -o auto_unmount .host:/Music /mnt/virtual/music/