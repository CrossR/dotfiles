#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0
FAIL=1

PRIVATE_MODE=0

show_help () {

    cat << EOF
USAGE
    startFirefox.sh

FLAGS
    -p PrivateMode  [optional] Start firefox in private mode.

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

FIREFOX="/Applications/Firefox.app"
DISOWN="> /dev/null 2>&1 & disown"

OSA_FIREFOX="tell application \"Firefox\" to activate"
OSA_KEYS="tell application \"System Events\" to keystroke "

# If Firefox is running, interact with it via osascript.
# If it isn't then open it.
if pgrep -x "firefox" > /dev/null; then

    # osascript -e "${OSA_FIREFOX}"

    if [ ${PRIVATE_MODE} -eq 0 ]; then
        osascript -e "${OSA_FIREFOX}" -e "${OSA_KEYS} \"n\" using command down"
    else
        osascript -e "${OSA_FIREFOX}" -e "${OSA_KEYS} \"p\" using {command down, shift down}"
    fi
else
    if [ ${PRIVATE_MODE} -eq 0 ]; then
        open -a ${FIREFOX}
    else
        bash -c "${FIREFOX}/Contents/MacOS/firefox -private-window ${DISOWN}"
    fi
fi

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}

