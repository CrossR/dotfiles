#!/bin/sh

xrandr --newmode "3840x2160_60.00"  712.34  3840 4152 4576 5312  2160 2161 2164 2235  -HSync +Vsync
xrandr --addmode Virtual-1 3840x2160_60.00
xrandr --output Virtual-1 --mode 3840x2160_60.00
feh --bg-scale /home/Downloads/space-shuttle-16092-1920x1080.jpg
