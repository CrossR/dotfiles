#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0

BROWSER="firefox"
PRIVATE="p"

ACTIVATE_BROWSER="tell application \"${BROWSER}\" to activate"
ACTIVATE_KEYS="tell application \"System Events\" to keystroke "

# Now the browser is running, interact with it via osascript.
if pgrep -x "${BROWSER}" > /dev/null; then
    osascript -e "${ACTIVATE_BROWSER}"  -e "${ACTIVATE_KEYS} \"n\" using command down"
else
    osascript -e "${ACTIVATE_BROWSER}"
fi

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}

