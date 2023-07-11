#!/bin/sh

. common_envs.sh

# After game starts
# \[game\]: start round type

# Server port
EC_PORT=${EC_PORT:-8303}

grepTheServer() {
    echo "$EC_PASSWORD" | nc "$TW_HOST" "$EC_PORT" | grep -aom1 "$1"
}

sendToServer() {
    nc -Nw "$CONNECTION_TIMEOUT" "$TW_HOST" "$EC_PORT"
}

case "$1" in
    default)
        if grepTheServer "$CONDITION"
        then
            totalOutput.sh "$(splittedCommands.sh)" | sendToServer
            echo "[exec] Condition satisfied!"
        fi
        ;;

    deadinside)
        if grepTheServer ': ?'
        then
            echo "[exec] Condition satisfied!"
            i=3
            totalOutput.sh "say Game stopped" "pause" | sendToServer
		    while [ "$i" -gt 0 ]
		    do
                totalOutput.sh "say $i..." | sendToServer
                sleep 1
    			i=$((i-1))
            done
            totalOutput.sh "say Game on" "pause" | sendToServer
            echo "[info] Sleeping $INTERVAL second[s]..."
            sleep "$INTERVAL"
        fi

esac
