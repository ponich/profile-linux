#!/usr/bin/env zsh

alias c="clear"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gs="git status"
alias gclean="git clean -fd; git checkout ."
alias cda="composer dump-autoload"
alias phpq="phpunit --testdox"
alias phpqq="composer test"
alias xdebugoff='sudo phpdismod -s cli xdebug; sudo phpdismod xdebug; sudo service apache2 restart'
alias xdebugon='sudo phpenmod -s cli xdebug; sudo phpenmod xdebug; sudo service apache2 restart'
