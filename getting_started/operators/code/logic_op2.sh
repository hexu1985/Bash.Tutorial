#!/bin/bash

a=10
b=20

if (( a != b ))
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi

if (( a < 100 && b > 15 ))
then
   echo "$a < 100 && $b > 15 : 返回 true"
else
   echo "$a < 100 && $b > 15 : 返回 false"
fi

if (( a < 100 || b > 100 ))
then
   echo "$a < 100 || $b > 100 : 返回 true"
else
   echo "$a < 100 || $b > 100 : 返回 false"
fi

if (( a < 5 || b > 100 ))
then
   echo "$a < 5 || $b > 100 : 返回 true"
else
   echo "$a < 5 || $b > 100 : 返回 false"
fi

