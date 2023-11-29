#!/bin/bash
# Author: Ali Moradzade

# testing multiple commands in the then section
testuser=ali

if grep $testuser /etc/passwd
then
    echo "This is my first command"
    echo "This is my second command"
    echo "I can even put in other commands besides echo:"
    ls -lhs /home/$testuser/.b*
fi
