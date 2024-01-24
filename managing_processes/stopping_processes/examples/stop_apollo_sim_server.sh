#!/bin/bash


for i in 1 2
do
    if pkill -0 -f 'sim_server.py'
    then
        pkill -SIGINT -f 'sim_server.py'
    else
        exit 0
    fi
    sleep 1
done

pkill -SIGKILL -f 'sim_server.py'

