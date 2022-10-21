#!/bin/bash

#Banner
echo -e "
scscanner- Massive Status Code Scanner
Codename : EVA02\n"

# Colors 
red="\033[0;31m"    # Error / Issues
green="\033[0;32m"  # Successful
reset="\033[0m"     # Normal

# Variable
process=15 # Multi-processing
useragent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
statuscode(){
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
    echo -e "Usage: $0 list.txt\n";
    exit 1
fi

# Do the jobs
for hostlists in $(cat $1);
do
    statusresult &
    background=( $(jobs -p) )
    if (( ${#background[@]} == process )); then
        wait -n
    fi
done
wait

# Exit after done
echo  -e "\nAll jobs done. Thank you"
exit 0
