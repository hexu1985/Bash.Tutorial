#!/bin/bash

policy=${FULL_BAG_RECORDER_POLICY:-"AUTO_START_FULL_BAG_RECORDER"}
config_file=${RECORD_SERVICE_CONFIG_FILE:-"./record_service_config.py"}

if [[ $# -gt 0 ]]
then
    policy=$1
fi

sed -i "s/^FULL_BAG_RECORDER_POLICY = .*/FULL_BAG_RECORDER_POLICY = ${policy}/g" ${config_file}
