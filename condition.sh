#!/bin/sh

. common_envs.sh
. condition_envs.sh

# After game starts
# \[game\]: start round type

if echo "$EC_PASSWORD" | nc "$TW_HOST" "$EC_PORT" | grep -q "$1"
then
    output.sh CONDITION | nc -N "$TW_HOST" "$EC_PORT"
    echo "[exec] Condition satisfied!"
fi
