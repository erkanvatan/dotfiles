#!/usr/bin/env bash

# Prints ***REMOVED***'s 5 days weather in ANSI
# LOCATION is a environment variable defined in .zshenv

if [[ -x $(which ansiweather) ]]; then
    ansiweather -u metric -F -l $LOCATION -s true -d true -w true -h true > /tmp/weather
    str=$(cat /tmp/weather)
    first_line=1

    IFS='-' # hyphen (-) is set as delimiter

    read -ra ADDR <<< "$str" # str is read into an array as tokens separated by IFS
    for i in "${ADDR[@]}"; do # access each element of array
        if [ $first_line -ne 1 ]; then
	    echo -n "                             "
        fi
        echo "$i"
        first_line=0
    done
    IFS=' ' # reset to default value after usage
fi
