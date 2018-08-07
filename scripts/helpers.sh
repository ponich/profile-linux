#!/usr/bin/env bash

# заменяем часть текста или создаем новый в файле
text_replace_create(){
	if grep -q ${1} ${3}; then
		sed -i "/${1}/c\\${2}" ${3}
	else
	    echo ${2} >> ${3}
	fi
}

