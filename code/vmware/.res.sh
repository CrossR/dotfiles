#!/bin/sh

xrandr --newmode "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
xrandr --addmode Virtual-1 1920x1080_60.00
xrandr --output Virtual-1 --mode 1920x1080_60.00
feh --bg-scale /home/Downloads/space-shuttle-16092-1920x1080.jpg
