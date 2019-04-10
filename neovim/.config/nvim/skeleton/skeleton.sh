#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0
FAIL=1

GIT_DIR="${HOME}/git"
TOOLS="${HOME}/tools"

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

LogMessage() {
    echo -e "${GREEN}$(date +'%d/%m/%Y %X')" : "$*${NC}"
}

LogWarning() {
    echo -e "${YELLOW}$(date +'%d/%m/%Y %X')" : "$*${NC}"
}

LogError() {
    echo -e "${RED}$(date +'%d/%m/%Y %X')" : "$*${NC}"
}

RunAndCheck() {
    eval "$1"
    RETURN_CODE=$?

    if [ $RETURN_CODE -ne 0 ] && [ "$3" = "ERR" ]; then
        LogError "$2"
        exit ${FAIL}
    elif [ $RETURN_CODE -ne 0 ] && [ "$3" = "WARN" ]; then
        LogWarning "$2"
    fi
}

show_help () {

    cat << EOF
USAGE

FLAGS

DEFAULTS

EOF
}

while getopts "h?" opt;
do
    case $opt in
        h|\?)
            show_help
            return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}
            ;;
    esac
done

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}
