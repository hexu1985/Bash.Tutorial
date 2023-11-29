#!/bin/bash

a=10
b=20

if (( a == b ))
then
   echo "$a == $b : a 等于 b"
else
   echo "$a == $b: a 不等于 b"
fi

if (( a != b ))
then
   echo "$a != $b: a 不等于 b"
else
   echo "$a != $b : a 等于 b"
fi

if (( a > b ))
then
   echo "$a > $b: a 大于 b"
else
   echo "$a > $b: a 不大于 b"
fi

if (( a < b ))
then
   echo "$a < $b: a 小于 b"
else
   echo "$a < $b: a 不小于 b"
fi

if (( a >= b ))
then
   echo "$a >= $b: a 大于或等于 b"
else
   echo "$a >= $b: a 小于 b"
fi

if (( a <= b ))
then
   echo "$a <= $b: a 小于或等于 b"
else
   echo "$a <= $b: a 大于 b"
fi

