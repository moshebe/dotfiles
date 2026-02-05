if [ "$(uname)" == "Darwin" ]
then
	echo "› macos settings"
	# sudo softwareupdate -i -a  # Commented out: requires password
	./macos/defaults.sh
fi
