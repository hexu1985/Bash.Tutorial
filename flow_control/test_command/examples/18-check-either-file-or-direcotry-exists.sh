#!/bin/bash
# Author: Ali Moradzade

# Check if either a directory or file exists

location=$HOME/works/linux-bible/test
file_name="sentinel"

if [ -e $location ]
then # Directory does exist
	echo "OK on the $location directory."
	echo "Now checking on the file, $file_name"

	if [ -e $location/$file_name ]
	then # File does exist
		echo "OK on the $file_name"
		echo "Updating Current Date ..."
		date >> $location/$file_name

		echo
		echo "$file_name content:"
		cat $location/$file_name

	else # File does not exist
		echo "File does not exist"
		echo "Nothing to update"
	fi

else # Directory does not exist
	echo "The $location directory does not exist."
	echo "Nothing to update"
fi

