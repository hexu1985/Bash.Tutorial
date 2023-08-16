#!/bin/bash

debug=1

CURRENT_FILE_NAME=$(basename $0)
LOGFILE_PATH=
MESSAGE_PATTERN=
WAITING_TIMEOUT_SEC=3

print_usage() {
    echo 'usage: wait_log_message.sh -f logfile_path -p message_pattern [-t timeout_sec]'
}

# count_message include exclude
count_message() {
    local message_pattern=$1
    local logfile_path=$2
    grep "${message_pattern}" "${logfile_path}" | wc -l
}

while getopts f:p:t: opt; do
    case $opt in
        f  ) LOGFILE_PATH="${OPTARG}" ;;
        p  ) MESSAGE_PATTERN="${OPTARG}" ;;
        t  ) WAITING_TIMEOUT_SEC="${OPTARG}" ;;
        \? ) print_usage
             exit 1
    esac
done

if [ -z "$LOGFILE_PATH" ]
then
    print_usage
    exit 1
fi

if [ -z "$MESSAGE_PATTERN" ]
then
    print_usage
    exit 1
fi

for i in $(seq ${WAITING_TIMEOUT_SEC})
do
    count=`count_message "${MESSAGE_PATTERN}" "${LOGFILE_PATH}"`
    ((debug)) && echo "count: ${count}"
    if (( count >= 1 ))
    then
        echo "found ${MESSAGE_PATTERN}, count ${count}"
        exit 0
    fi
    sleep 1
done

echo "not found ${MESSAGE_PATTERN}"
exit 1

