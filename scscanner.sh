#!/bin/bash

# Color definition
: "${blue:=\033[0;34m}"
: "${cyan:=\033[0;36m}"
: "${reset:=\033[0m}"
: "${red:=\033[0;31m}"
: "${green:=\033[0;32m}"
: "${orange:=\033[0;33m}"
: "${bold:=\033[1m}"
: "${b_green:=\033[1;32m}"
: "${b_red:=\033[1;31m}"
: "${b_orange:=\033[1;33m}"


# Banner
echo " ___ __ ___ __ __ _ _ _  _ _  ___ _ _  ";
echo "(_-</ _(_-</ _/ _\` | ' \| ' \/ -_) '_|";
echo "/__/\__/__/\__\__,_|_||_|_||_\___|_|   ";
echo "      Massive HTTP Status Code Scanner ";
echo "";
# Check if curl is installed
command -v curl &> /dev/null || { printf '%s\n' "Curl not installed. You must install curl to use this tool." >&2 ; exit 1 ;}

# Variable
process=15 # Default multi-process
useragent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"

# Function
showHelp()
{
	while read -r help; do
		printf '%s\n' "${help}"
	done <<-EOF
	
	A Tool that read/checks website's HTTP response code from the lists.
	Usage:
		${0} [-l <domain.txt>] [-t {int}] [-o <out.txt>]
		${0} [-h]
	
	Options:
		-l     File contain lists of domain.
		-t     Adjust multi process. (Default: 15)
		-f     Filter status code.
		-o     Save to file.
		-h     Print this Help.
	EOF
}

statuscode()
{
	if [[ "${1}" == 1 ]]; then
		req=$(curl -k -A "${useragent}" --connect-timeout 10 --write-out "%{http_code}" --silent --output /dev/null "${2}")
		if [[ $req == "$3" ]]; then
			printf '[%s] - %s\n' "${req}" "${2}"
			printf '%s\n' "${2}" >> "${req}-${4}"
		fi
	else
		if [[ -z "$3" ]]; then
			curl -k -A "${useragent}" --connect-timeout 10 --write-out "[%{http_code}] - ${hostlists}\n" --silent --output /dev/null "${2}"
		else
			req=$(curl -k -A "${useragent}" --connect-timeout 10 --write-out "%{http_code}" --silent --output /dev/null "${2}")
			[[ "${req}" == "${3}" ]] && printf '[%s] - %s\n' "${req}" "${hostlists}"
		fi
	fi
}

if [[ -z "${1}" ]]; then
	showHelp
	exit 0
fi

while getopts ":hl:t:f:o:" opt; do
	case "${opt}" in
		h)
			showHelp
			exit 0
			;;
		l)
			domainlists="${OPTARG}"
			;;
		t)
			proc_limit="$(ulimit -u)"
			if ! [[ "${OPTARG}" =~ ^[0-9]+$ ]] || [[ "${OPTARG}" -gt "${proc_limit}" ]] || [[ "${OPTARG}" -le 0 ]] ; then
				printf '%s\n' "Error: invalid thread value, the possible value must be (1-${proc_limit})" >&2
				exit 1 # failure
			fi
			process="${OPTARG}"
			;;
		f)
			if ! [[ "${OPTARG}" =~ ^[1-5][0-9]{2}$ ]]; then
				printf '%s\n' "Error: invalid status code value" >&2
				exit 1 # failure
			fi
			filter="${OPTARG}"
			;;
		o)
			output="${OPTARG}"
			;;
		\?)
			printf 'invalid option: - %s\n' "${OPTARG}" >&2
			exit 1
			;;
		:)
			printf 'option -%s requires an argument.\n' "${OPTARG}" >&2
			exit 1
			;;
	esac
done

shift "$((OPTIND-1))"
: "${domainlists:="${1}"}"


if [[ -z "${domainlists}" ]] || [[ ! -f "${domainlists}" ]]; then
	printf '%s\n' "Please provide valid domain list file." >&2
	exit 1
fi
if [[ -z "${output}" ]]; then
	saved=0
else
	if [[ -z "${filter}" ]]; then
		printf '%s\n' "If you're using -o (output), -f is mandatory (filter)" >&2
		exit 1
	else
		saved=1
	fi
fi

# Do the jobs
while IFS= read -r hostlists; do
	[[ -z "${hostlists}" ]] && continue
	statuscode "${saved}" "${hostlists/$'\r'/}" "${filter}" "${output}" &
	[[ "$(jobs | wc -l)" -ge "${process}" ]] && wait -n
done <<< "$(<"${domainlists}")"
wait
