#!/bin/bash

safety_grading_pid=$(ps aux | grep '[s]afety_error_code_counter.py' | awk '{print $2}')

for i in 1 2
do
    kill -SIGINT ${safety_grading_pid} 
    sleep 1
done

