#!/usr/bin/env bash

# равен нулю, если был запущен сам по себе напрямую
PROFILE_INDEX=${PROFILE_INDEX:-0}

# редактор, по умолчанию vim todo: добавить nvim
VIM_EDITOR="vim"

dt=$(date '+%Y%m%d_%H%M%S');

#
# https://unix.stackexchange.com/a/204927
while [ $# -gt 0 ]; do
  case "$1" in
    --nvim)
      VIM_EDITOR="nvim"
      ;;
    *)
  esac
  shift
done

# данный скрипт запущен сам по себе напрямую
if [ $PROFILE_INDEX == 0 ]; then
    PROFILE_ROOT_PATH=${PROFILE_ROOT_PATH:-$(realpath $(dirname $0)"/..")}

    # заменяем часть текста или создаем новый в файле
    text_replace_create(){
        if grep -q ${1} ${3}; then
            sed -i "/${1}/c\\${2}" ${3}
        else
            echo ${2} >> ${3}
        fi
    }
fi

# путь к каталогу с конфигами vim
PROFILE_VIM_ROOT_PATH=${PROFILE_ROOT_PATH}"/vim"

# путь к vimrc файлу
VIM_SOURCE=~/.vimrc

# путь vim каталогу
VIM_DATA=~/.vim

# резервная копия vimrc файла при необходимости
backup(){
    if [ -f $VIM_SOURCE ]; then
        cp ${VIM_SOURCE} ${PROFILE_ROOT_PATH}"/data/vimrc_"${dt}".vim"
        rm ${VIM_SOURCE}
    fi
}

pushdir(){
    mkdir -p ${VIM_DATA}/{autoload,plugged,spell}
}

# ссылка на файл конфигурации
rc(){
    ln -sfn ${PROFILE_VIM_ROOT_PATH}/vimrc ${VIM_SOURCE}
}

# файлы для проверки правописания
spell(){
    # ru.utf-8.spl ru.utf-8.sug
    wget -q -nc -P ${VIM_DATA}/spell "ftp://ftp.vim.org/pub/vim/runtime/spell/ru.utf-8.sug"
    wget -q -nc -P ${VIM_DATA}/spell "ftp://ftp.vim.org/pub/vim/runtime/spell/ru.utf-8.spl"
}

# установка $PROFILE_ROOT_PATH
profile(){
    rcfile=${1:-~/.bashrc}

    if [ -f ${rcfile} ]; then
        text_replace_create "PROFILE_ROOT_PATH" "export PROFILE_ROOT_PATH="${PROFILE_ROOT_PATH} ${rcfile}
    fi
}

#backup
pushdir
profile ~/.bashrc
profile ~/.zshrc
spell
rc

vim -s ${VIM_SOURCE} +PlugInstall +qall
