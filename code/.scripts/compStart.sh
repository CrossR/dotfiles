#!/bin/sh

killall -q compton

while pgrep -x compton > /dev/null;
do
    sleep 1;
done

compton -b --backend xrender 2&>1
