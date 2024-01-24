#!/bin/bash

for i in 1 2
do
    pkill -SIGINT -f 'mainboard.*routing.dag'
    pkill -SIGINT -f 'cyber_launch.*start.*routing.launch'
    sleep 1
done

pkill -SIGKILL -f 'mainboard.*routing.dag'
pkill -SIGKILL -f 'cyber_launch.*start.*routing.launch'

