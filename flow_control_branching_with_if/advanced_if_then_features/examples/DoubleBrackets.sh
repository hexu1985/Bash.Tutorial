#!/bin/bash
# Using double brackets for pattern matching
#
#
echo "BASH_VERSION: $BASH_VERSION"
if [[ $BASH_VERSION == 4.* ]]
then
    echo "You are using the Bash Shell version 4 series."
fi
