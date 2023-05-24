#!/bin/bash

a=10
b=20
val=0

let 'val = a + b'
echo "a + b : $val"

let 'val = a - b'
echo "a - b : $val"

let 'val = a * b'
echo "a * b : $val"

let 'val = b / a'
echo "b / a : $val"

let 'val = b % a'
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a 等于 b"
fi

if [ $a != $b ]
then
   echo "a 不等于 b"
fi
