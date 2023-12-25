#!/bin/bash

for host in `grep "^192\.168\.1\." /etc/hosts | awk '{ print $2 }'`
do
    ping -c1 -w1 $host > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo "$host is up"
    else
        echo "$host is down"
    fi
done
