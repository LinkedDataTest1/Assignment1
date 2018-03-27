#!/bin/bash

#Name: testCSV.sh
#Description: Validates student csv file
#Parameters: none
#Output: Descriptions of lines with incorrect number of fields, or none if the files are correct
#Exit Value: Number of errors found, 0 if the file was correct

errors=0
sleep 2
username=$(curl -s -X GET "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}" | jq -r '.user.login')

if [ ! -f "$username.csv" ]; then
  echo "File missing. Make sure it has the correct format" "$username.csv"
  errors=$((errors+1))
else
	file=$username.csv
	numberfields=2
	awk -v n=$numberfields 'BEGIN{FS=OFS=","} NF==n{count++} NF!=n{print "ERROR in file " FILENAME " line "   count+1 " Incorrect number of fields"; errors++; count++} END {if ( errors != 0  ) {exit 1}}' $file
	if [[ $? -ne 0 ]]
	then
		errors=$((errors+1))
	fi
fi

exit $errors
