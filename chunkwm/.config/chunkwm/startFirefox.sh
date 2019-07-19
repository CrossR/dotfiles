#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0

PRIVATE_MODE=0

show_help () {

    cat << EOF
USAGE
    startBrowser.sh

    Launch Firefox or Safari.
    Firefox on AC Power, Safari otherwise.

FLAGS
    -p PrivateMode  [optional] Start browser in private mode.

DEFAULTS

EOF
}

while getopts "h?p" opt;
do
    case $opt in
        h|\?)
            show_help
            return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}
            ;;
        p)
            PRIVATE_MODE=1
            ;;
    esac
done

if [[ $(pmset -g ps | head -1) =~ "AC Power" ]]; then
    BROWSER="firefox"
    PRIVATE="p"
else
    BROWSER="Safari"
    PRIVATE="n"
fi

ACTIVATE_BROWSER="tell application \"${BROWSER}\" to activate"
ACTIVATE_KEYS="tell application \"System Events\" to keystroke "

# Now the browser is running, interact with it via osascript.
if [ ${PRIVATE_MODE} -eq 0 ]; then
    if pgrep -x "${BROWSER}" > /dev/null; then
        osascript -e "${ACTIVATE_BROWSER}"  -e "${ACTIVATE_KEYS} \"n\" using command down"
    else
        osascript -e "${ACTIVATE_BROWSER}"
    fi
else
    osascript -e "${ACTIVATE_BROWSER}" -e "${ACTIVATE_KEYS} \"${PRIVATE}\" using {command down, shift down}"
fi

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}

