#!/bin/sh
xrandr --output VGA-1 --auto --right-of VGA-0
xrandr --newmode "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
xrandr --addmode VGA-1 1920x1080_60.00
xrandr --output VGA-1 --mode 1920x1080_60.00
feh --bg-scale /home/ryanc/Downloads/background.png
