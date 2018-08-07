#!/usr/bin/env bash

PROFILE_INDEX=${PROFILE_INDEX:-0}
PROFILE_ROOT_PATH=${PROFILE_ROOT_PATH:-$(realpath $(dirname $0)"/..")}
PROFILE_TMUX_ROOT_PATH=${PROFILE_ROOT_PATH}"/tmux"
TMUX_SOURCE=~/.tmux.conf
TMUX_DATA=~/.tmux

dt=$(date '+%Y%m%d_%H%M%S');

#
backup(){
    if [ -f ${TMUX_SOURCE} ]; then
        cp ${TMUX_SOURCE} ${PROFILE_ROOT_PATH}"/backup/tmux_"${dt}".vim"
        rm ${TMUX_SOURCE}
    fi
}

#
plugins(){
    git clone https://github.com/tmux-plugins/tpm ${TMUX_DATA}/plugins/tpm >> /dev/null 2>&1
}

#
rc(){
    ln -sfn ${PROFILE_TMUX_ROOT_PATH}/tmux.conf ${TMUX_SOURCE}
    ln -sfn ${PROFILE_TMUX_ROOT_PATH}/user.conf ${TMUX_SOURCE}".local"
}

#backup
plugins
rc

tmux source-file ${TMUX_SOURCE}