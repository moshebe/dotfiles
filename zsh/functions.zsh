function contained() {
	docker run -it --rm -v $(pwd):/workspace -w /workspace $@
}
function contained-priv() {
	docker run -it --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace -w /workspace $@
} 

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

function alert() {
	if [ -z "$@" ]; then msg="Command finished"; else msg="$@"; fi
	osascript -e "tell app \"System Events\" to display dialog \"$msg\""
}

# function to send man page to Preview
manpreview() { man -t $* | open -f -a /Applications/Preview.app/ }

function xmanpage() { open x-man-page://$@ ; }

function rundc() {
	cd "${DEVDIR}/${1}"
	docker-compose up --remove-orphans
	cd -
}

function finnotify() {
	#rundc bank &
	rundc psagot &
	rundc fnx &
}

function portlisten() {
	lsof -nPi:$1 -sTCP:LISTEN
}

function portlistenpid() {
	portlisten $1 | awk '{if (NR>1) print $2}'	
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

function ipinfo() {
	curl -sL "ipinfo.io/$1" | jq
}

function taildevice() {
	device_id=$1	
	device_log_pod_name=$(kubectl get pods | grep "device-logger" | cut -f1 -d" ")
	if [ -n $device_id ]; then
		kubectl logs -f $device_log_pod_name | grep ":${device_id}\}"
	else
		kubectl logs -f $device_log_pod_name
	fi
}

function loadenv() {
	if [ -f .env ]
	then
	export $(cat .env | sed 's/#.*//g' | xargs)
	fi
}

function searchcode() {
	phrase=$(urlencode $1) 
	url="https://github.com/search?q=org%3Atorqio+$phrase&type=code"
	open $url
}

function setenv() {
	export $(grep -v '^#' .env | xargs -0)
}

function unsetenv() {
	unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
}

function unsetallenv() {
	unset $(grep -v "^$" .env | sed -E 's/(.*)=.*/\1/' | sed -E 's/^#//' | xargs)	
}

function yaml2json {
  python -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin.read())))'
}

function runcdc() {
	cd "$HOME/dev/moshebe/$1"
	docker-compose up --remove-orphans
	cd -
}