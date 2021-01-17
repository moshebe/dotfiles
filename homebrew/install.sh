#!/usr/bin/env sh

if test ! $(which brew)
then
	if [ "$(uname)" == "Darwin" ]
	then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "Unsupported OS: $(uname)"
	fi
fi
