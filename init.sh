#!/bin/sh

# ---------- #
# INIT BLOCK #
# ---------- #

. common_envs.sh

sendToServer() {
    nc -Nw "$CONNECTION_TIMEOUT" "$TW_HOST" "$i"
}

echo "[init] MODE=$MODE"
echo "[init] DRY=$DRY"
echo "[init] EC_PASSWORD=$EC_PASSWORD"
echo "[init] EC_PORT=$EC_PORT"
echo "[init] INTERVAL=$INTERVAL"
echo "[init] MULTILINE=$MULTILINE"
echo "[init] TW_HOST=$TW_HOST"

if [ -n "$TZ" ]
then
	echo "[init] TZ=$TZ"
	cp /usr/share/zoneinfo/"$TZ" /etc/localtime
	echo "$TZ" > /etc/timezone
fi

VERSION=0.0.4
echo "[init] VERSION=$VERSION"

# --------------- #
# EXECUTION BLOCK #
# --------------- #

# Spammer mode
# NetCat commands on server and sleep after it
echo '[exec] And here we go...'
case $MODE in
    spammer)
        # Server[s] port[s]
        # TODO: add more efficient and powerful port parsing
        if [ -z "$EC_PORT" ]
        then
            EC_PORT=8303
        else    
            case $EC_PORT in *:*)
            	EC_PORT_START=${EC_PORT%:*}
            	EC_PORT_END=${EC_PORT#*:}
            	EC_PORT=''
        		i=$EC_PORT_START
            	while [ "$i" -le "$EC_PORT_END" ]
            	do
        			EC_PORT="$EC_PORT$i "
            		i=$((i+1))
            	done
        		;;
            esac
        fi
        while true
        do
            for i in $EC_PORT
            do
                cantConnect() {
                    echo "[err] Can not connect to the server..."
                    exit 1
                }

                wrongPassword() {
                    echo "[err] Wrong password!"
                    exit 2
                }

                echo "$EC_PASSWORD" | nc -N "$TW_HOST" "$i" || cantConnect
                totalOutput.sh "$(splittedCommands.sh)" | sendToServer | \
                   grep -q "Authentication successful." || wrongPassword
            done
            echo "[info] Sleeping $INTERVAL second[s]..."
            sleep "$INTERVAL"
        done
    ;;

    # Condition mode
    # Listens server
    # NetCat commands on server then condition satisfied
    condition)
        # Specify string as condition
        while true
        do
            echo '[splt] ---'
            echo '[exec] Waiting condition to be satisfied...'
            echo "$EC_PASSWORD" | nc -N "$TW_HOST" "$EC_PORT" || exit 1
            condition.sh "$CONDITION_MODE"
        done
    ;;
esac
