#!/bin/bash

#Name: testCSV.sh
#Description: Validates csv files against a determined number of fields
#Parameters: pairs of file_name number_of_fields
#Output: Descriptions of lines with incorrect number of fields, or none if the files are correct
#Exit Value: Number of errors found, 0 if the files were correct

if [[ $(( $# % 2 )) -ne 0 ]]
then
	echo "Incorrect Usage: " $0 "[file  numberOfFields]"
	exit 1
fi

arguments=( "$@" )
errors=0

while [[ ${#arguments[@]} > 0 ]]
do
	file=${arguments[0]}
	numberfields=${arguments[1]}
	awk -v n=$numberfields 'BEGIN{FS=OFS=","} NF==n{count++} NF!=n{print "ERROR in file " FILENAME " line "   count+1 " Incorrect number of fields"; errors++; count++} END {if ( errors != 0  ) {exit 1}}' $file
	if [[ $? -ne 0 ]]
	then
		errors=$((errors+1))
	fi
	arguments=("${arguments[@]:2}")
done

exit $errors
