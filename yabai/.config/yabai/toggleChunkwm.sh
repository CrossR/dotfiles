#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0
FAIL=1

while getopts "h?" opt;
do
    case $opt in
        h|\?)
            show_help
            return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}
            ;;
    esac
done

if pgrep -x "yabai" > /dev/null; then
    launchctl unload /Library/LaunchAgents/com.koekeishiya.yabai.plist
else
    launchctl load /Library/LaunchAgents/com.koekeishiya.yabai.plist
fi

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}

