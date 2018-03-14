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
	awk -v n=$numberfields 'BEGIN{FS=OFS=","} NF==n{count++} NF!=n{print "ERROR in file " FILENAME " line "   count+1 " Incorrect number of fields\n" $0; exit 1}' $file
	if [[ $? -ne 0 ]]
	then
		exit 1
	fi
	arguments=("${arguments[@]:2}")
done