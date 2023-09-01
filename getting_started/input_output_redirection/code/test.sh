#!/bin/bash

rm -f users

# output redirection
echo "test output redirection"
set -x 
who > users
cat users

echo "菜鸟教程：www.runoob.com" > users
cat users

echo "菜鸟教程：www.runoob.com" >> users
cat users
set +x

# input redirection
echo "test input redirection"
set -x 

wc -l users
wc -l < users
