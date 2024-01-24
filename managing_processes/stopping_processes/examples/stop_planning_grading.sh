#!/bin/bash

for i in 1 2
do
    pkill -SIGINT -f 'planning_grading'
    sleep 1
done

pkill -SIGKILL -f 'planning_grading'
