#!/usr/bin/env zsh

DIR=$0:a:h

# profile root absolute path
export PROFILE_ROOT_PATH=$(realpath ${DIR}"/..")
PROFILE_ZSH_ROOT_PATH=${PROFILE_ROOT_PATH}"/zsh"

#
export LANG=ru_RU.UTF-8
export LC_CTYPE=ru_RU.UTF-8

# добавить путь в $PATH
add_path(){
	path+=($1)
}

# подключить файл
include_file(){
	source ${PROFILE_ZSH_ROOT_PATH}/$1
}

#
include_dir(){
    for file in $(find $1 -type f);
    do
        source $file
    done
}

# brew
# git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
add_path_brew(){
    export HOMEBREW_NO_ENV_FILTERING=1
    add_path $HOME/.linuxbrew/bin/

    if hash brew 2>/dev/null; then
        export MANPATH="$(brew --prefix)/share/man:$MANPATH"
        export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
    else
        echo "brew not found" >/dev/null
    fi
}

# include helpers
include_dir ${PROFILE_ZSH_ROOT_PATH}/helpers/

# zsh
add_path ${PROFILE_ZSH_ROOT_PATH}/bin/

# composer
add_path $HOME/.config/composer/vendor/bin

# npm & nodejs
add_path $HOME/.npm-global/bin

# local
add_path /usr/local

# brew
add_path_brew

# редактор по умолчанию
export VISUAL=vim
export EDITOR=vim

#  History
# хранить историю в указанном файле
export HISTFILE=${PROFILE_ROOT_PATH}/data/zsh_history
# максимальное число команд, хранимых в сеансе
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
# включить историю команд
setopt APPEND_HISTORY
# убрать повторяющиеся команды, пустые строки и пр.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# plugins
plugins+=(
  composer,
  git,
  laravel5
)

# themes
ZSH_THEME="awesomepanda"
#ZSH_THEME="robbyrussell"

# include aliases
include_dir ${PROFILE_ZSH_ROOT_PATH}/aliases/

# run tmux
if [ "$TMUX" = ""  ]; then tmux; fi
