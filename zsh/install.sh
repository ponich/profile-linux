#!/usr/bin/env bash

PROFILE_INDEX=${PROFILE_INDEX:-0}
PROFILE_ROOT_PATH=${PROFILE_ROOT_PATH:-$(realpath $(dirname $0)"/..")}
PROFILE_ZSH_ROOT_PATH=${PROFILE_ROOT_PATH}"/zsh"
ZSH_SOURCE=~/.zshrc

# ohmyz
zsinstall(){
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

# заменяем часть текста или создаем новый в файле
text_replace_create(){
echo $3
	if grep -q ${1} ${3}; then
		sed -i "/${1}/c\\${2}" ${3}
	else
	    echo ${2} >> ${3}
	fi
}

# git configs
gitconfig(){
    ln -sfn ${PROFILE_ZSH_ROOT_PATH}"/configs/git/config" ~/.gitconfig
}

#
gitconfig

#
text_replace_create "zshrc.sh" "source "${PROFILE_ZSH_ROOT_PATH}"/zshrc.sh" ${ZSH_SOURCE}
