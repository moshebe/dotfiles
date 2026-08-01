if [ "$(uname)" == "Darwin" ]
then
	echo "› macos settings"
	# sudo softwareupdate -i -a  # Commented out: requires password
	"$(dirname "$0")/defaults.sh"

	# Setup Touch ID for sudo
	sudo_template="$(dirname "$0")/sudo_local.template"
	if [ -f "$sudo_template" ] && [ ! -f /etc/pam.d/sudo_local ]; then
		echo "› enabling Touch ID for sudo"
		sudo cp "$sudo_template" /etc/pam.d/sudo_local
	fi
fi
