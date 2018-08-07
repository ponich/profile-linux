#!/usr/bin/env bash

set -f

# variables
PROFILE_INDEX=1
PROFILE_ROOT_PATH=$(dirname $0)

# scripts
source ${PROFILE_ROOT_PATH}/scripts/getopts.sh
source ${PROFILE_ROOT_PATH}/scripts/helpers.sh

# options
parse_options "[ -f FORCE ]" ${@}


menu_level_1(){
    PS3='Mode: '
    options=("base" "vim" "tmux"  "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "base")
                # git configs
                # bin path
                # fix console
                # fix locale (readme.md)
                # add alias
            ;;

            "vim")
                source ${PROFILE_ROOT_PATH}/vim/install.sh >> /dev/null 2>&1
            ;;

            "tmux")
                source ${PROFILE_ROOT_PATH}/tmux/install.sh >> /dev/null 2>&1
            ;;

            "quit")
            break

            ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

menu_level_1