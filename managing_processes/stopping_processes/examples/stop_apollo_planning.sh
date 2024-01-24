#!/bin/bash

for i in 1 2
do
    pkill -SIGINT -f 'mainboard.*planning.dag'
    pkill -SIGINT -f 'cyber_launch.*start.*planning.launch'
    sleep 1
done

pkill -SIGKILL -f 'mainboard.*planning.dag'
pkill -SIGKILL -f 'cyber_launch.*start.*planning.launch'

