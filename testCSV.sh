#!/bin/bash

if [[ $(( $# % 2 )) -ne 0 ]]
then
	echo "Incorrect Usage: " $0 "[file  numberOfFields]"
	exit 1
fi

arguments=( "$@" )

while [[ ${#arguments[@]} > 0 ]]
do
	file=${arguments[0]}
	numberfields=${arguments[1]}
	awk -v n=$numberfields 'BEGIN{FS=OFS=","} NF==n{count++} NF!=n{print "ERROR in file " FILENAME " line "   count+1 " Incorrect number of fields"; errors++; count++} END {if ( errors != 0  ) {exit 1}}' $file
	if [[ $? -ne 0 ]]
	then
		error="true"
	fi
	arguments=("${arguments[@]:2}")
done

if [ error == "true" ]
then
	exit 1
fi
