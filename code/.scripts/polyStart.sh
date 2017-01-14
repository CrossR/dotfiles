#!/bin/sh

killall -q polybar

while pgrep -x polybar > /dev/null;
do
    sleep 1;
done

polybar bar1 > /dev/null 2>&1 &
