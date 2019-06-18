#!/bin/bash

IFS=$'\n'
for I in $(env); do
    if [[ $I == JAVA_OPTS_* ]]; then
        echo "-- collecting $I"
        VALUE=$(echo $I | cut -d '=' -f 2-)
        JAVA_OPTS="$JAVA_OPTS $VALUE"
    fi
done

# Trim leading/trailing whitespace
export JAVA_OPTS=$(echo $JAVA_OPTS | xargs echo)

echo "Result: JAVA_OPTS=${JAVA_OPTS}"