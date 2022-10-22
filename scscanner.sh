#!/bin/bash

#Banner
echo -e "
scscanner - Massive Status Code Scanner
Codename : EVA02\n"

# Colors 
red="\033[0;31m"    # Error / Issues
green="\033[0;32m"  # Successful
reset="\033[0m"     # Normal

# Variable
process=15 # Default multi-process
useragent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"

# Function
showHelp()
{
   # Display Help
   echo "Example: bash $0 -l domain.txt -t 30"
   echo "options:"
   echo "-l     Files contain lists of domain."
   echo "-t     Adjust multi process. Default is 15"
   echo "-h     Print this Help."
   echo
}

statuscode()
{
    curl -H "User-Agent: $useragent" --connect-timeout 3 --write-out "%{http_code}" --silent --output /dev/null $hostlists
}
statusresult(){
    if [[ $(statuscode) == '200' ]]; then
	 	echo -e "${green}[$(statuscode)]${reset} - $hostlists"
    elif
        [[ $(statuscode) == '403' ]]; then
	 	echo -e "${red}[$(statuscode)]${reset} - $hostlists"
  	else
 		echo "[$(statuscode)] - $hostlists"
    fi
}
if [ -z "$1" ]; then
    showHelp
    exit 0
fi
if [[ ! $@ =~ ^\-.+ ]]
then
  showHelp
  exit 1
fi
while getopts ":hl:t:" opt; do
    case $opt in
        h)  showHelp
            exit 0
            ;;
        l)  domainlists=$OPTARG
            ;;
        t)  if [[ ! "$OPTARG" =~ ^[0-9]+$ ]] && [[ ! $OPTARG -gt 0 ]]; then
            echo "Error: invalid thread value"
            exit 1 # failure
            fi
            process=$OPTARG
            ;;
        \?) echo "invalid option: -$OPTARG"
            exit 1
            ;;
        :)  echo "option -$OPTARG requires an argument."
            exit 1
            ;;    
    esac
done
shift "$((OPTIND-1))"
[ ! -f $domainlists ] && echo "Domain list not found. Check your file path!" && exit 1
# Do the jobs
while read hostlists; do
    statusresult &
    background=( $(jobs -p) )
    if (( ${#background[@]} == process )); then
        wait -n
    fi
done < "$domainlists"
wait

echo  -e "\nAll jobs done. Thank you!"
