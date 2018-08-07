#!/usr/bin/env bash

set -f

# variables
PROFILE_INDEX=1
PROFILE_ROOT_PATH=${PROFILE_ROOT_PATH:-$(realpath $(dirname $0))}

# заменяем часть текста или создаем новый в файле
text_replace_create(){
	if grep -q ${1} ${3}; then
		sed -i "/${1}/c\\${2}" ${3}
	else
	    echo ${2} >> ${3}
	fi
}

#
install_handle_base(){
    echo "Install base..."
    source ${PROFILE_ROOT_PATH}/zsh/install.sh
}

#
install_handle_vim(){
    echo "Install vim..."
    source ${PROFILE_ROOT_PATH}/vim/install.sh >> /dev/null 2>&1
}

#
install_handle_tmux(){
    echo "Install tmux..."
    source ${PROFILE_ROOT_PATH}/tmux/install.sh >> /dev/null 2>&1
}

#
install_handle_all(){
    install_handle_base
    install_handle_vim
    install_handle_tmux
}


menu_level_1(){
    PS3='Mode: '
    options=("all" "base" "vim" "tmux"  "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "all")
                install_handle_all
                break
            ;;

            "base")
                install_handle_base
            ;;

            "vim")
                install_handle_vim
            ;;

            "tmux")
                install_handle_tmux
            ;;

            "quit")
            break

            ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

menu_level_1