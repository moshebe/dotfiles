#!/usr/bin/env sh
#
# install homebrew
#

if test ! $(which brew)
then
	if [ "$(uname)" == "Darwin" ]
	then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"		
	else
		echo "Unsupported OS: $(uname)"
	fi
fi
