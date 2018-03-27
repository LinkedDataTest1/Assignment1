#!/bin/bash

#Name: testCSV.sh
#Description: Validates student csv file
#Parameters: none
#Output: Descriptions of lines with incorrect number of fields, or none if the files are correct
#Exit Value: Number of errors found, 0 if the file was correct

errors=0

TOKEN1=8c073f6335e29d1
TOKEN2=e06e0dbade3a8a78405449b5d
username=$(curl -H "Authorization: token $TOKEN1$TOKEN2" -X GET "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}" | jq -r '.user.login')

if [ ! -f "$username-$number.csv" ]; then
  echo "File missing. Make sure it has the correct format" "$username-$number.csv"
  errors=$((errors+1))
else
	file=$username-$number.csv
	numberfields=2
	awk -v n=$numberfields 'BEGIN{FS=OFS=","} NF==n{count++} NF!=n{print "ERROR in file " FILENAME " line "   count+1 " Incorrect number of fields"; errors++; count++} END {if ( errors != 0  ) {exit 1}}' $file
	if [[ $? -ne 0 ]]
	then
		errors=$((errors+1))
	fi
fi

exit $errors
