#!/bin/bash
# Author: Ali Moradzade

# testing a bad command
if IamNotaCommand
then
    echo "It worked"
fi
echo "We are outside the if statement"
