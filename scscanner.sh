#!/bin/bash
#Banner
echo -e "
scscanner - Massive Status Code Scanner
Codename : EVA02\n"

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
    curl -H "User-Agent: $useragent" --connect-timeout 3 --write-out "[%{http_code}] - $hostlists\n" --silent --output /dev/null $hostlists
}
if [ -z "$1" ] || [[ ! $@ =~ ^\-.+ ]]; then
    showHelp
    exit 0
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
if [ -z "$domainlists" ] || [ ! -f "$domainlists" ]; then
        echo "Please provide valid domain list file." >&2
        exit 1
fi
# Do the jobs
while read hostlists; do
    statuscode &
    background=( $(jobs -p) )
    if (( ${#background[@]} == process )); then
        wait -n
    fi
done < "$domainlists"
wait

echo  -e "\nAll jobs done. Thank you!"
