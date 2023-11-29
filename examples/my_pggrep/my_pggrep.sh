#!/bin/bash
# grep cmd_pattern and get PGID of cmd

debug=0

current_filename=$(basename $0)
((debug)) && echo "current_filename: ${current_filename}"

if [ $# -ne 1 ]
then
    echo "usage: ${current_filename} cmd_pattern"
    exit 1
fi

cmd_pattern=$1

ps ajx | grep "${cmd_pattern}" | \
while read line
do
    echo $line | grep -v 'grep' | awk '{print $3}'
done | sort | uniq

