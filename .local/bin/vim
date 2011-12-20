#!/bin/bash

exe="/usr/bin/vim"

if [[ $(uname) == 'Darwin' ]]; then
	if [[ -f /Applications/MacVim.app/Contents/MacOs/Vim ]]; then
		exe="/Applications/MacVim.app/Contents/MacOS/Vim -v"
	fi
elif [[ $(uname) == 'Linux' ]]; then
	if [[ -f /usr/bin/gvim ]]; then
		exe="/usr/bin/gvim -v"
	fi
fi

exec $exe $*
