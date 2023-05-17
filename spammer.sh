#!/bin/sh

# ---------- #
# INIT BLOCK #
# ---------- #

# Connection timeout
CONNECTION_TIMEOUT=${CONNECTION_TIMEOUT:-5}
echo "[init] CONNECTION_TIMEOUT=$CONNECTION_TIMEOUT"

# Needed for testing purpose
# DRY=0 cause script to work as usual
# DRY=1 cause script to just show commands, but not to send them on server
DRY=${DRY:-0}
echo "[init] DRY=$DRY"

# ECON password
EC_PASSWORD=${EC_PASSWORD:-password}
echo "[init] EC_PASSWORD=$EC_PASSWORD"

# Server[s] port[s]
. ec_port.sh
echo "[init] EC_PORT=$EC_PORT"

# Exit if REACHABLE=NO
ERROR_EXIT=${ERROR_EXIT:-0}
echo "[init] ERROR_EXIT=$ERROR_EXIT"

# Spam interval
INTERVAL=${INTERVAL:-300}
echo "[init] INTERVAL=$INTERVAL"

# Server IP host
TW_HOST=${TW_HOST:-127.0.0.1}
echo "[init] TW_HOST=$TW_HOST"

# Change timezone if specified
if [ -n "$TZ" ]
then
		echo "[init] TZ=$TZ"
		cp /usr/share/zoneinfo/"$TZ" /etc/localtime
		echo "$TZ" > /etc/timezone
fi

# If $DRY=1 then just echo $COMMANDS and exit
if [ "$DRY" -eq 1 ]
then
		echo
		echo '[init] COMMANDS'
		commands.sh
		echo '[init] COMMANDS'
		exit
fi

# Return 1 if there's no CMDs
if ! env | grep -q "^CMD"
then
		echo "Looks like you didn't specify commands. Exiting."
		exit 1
fi

# --------------- #
# EXECUTION BLOCK #
# --------------- #

# Execution of all commands and netcat it on server[s]
echo '[exec] And here we go...'
while true
do
		for i in $EC_PORT
		do
				echo '[splt] -------'
				echo "[info] DATE=$(date)"
				echo "[info] TW_HOST=$TW_HOST"
				echo "[info] EC_PORT=$i"

				if echo "$EC_PASSWORD" | \
						nc -Nw "$CONNECTION_TIMEOUT" "$TW_HOST" "$i" > /dev/null
				then
						echo "[info] REACHABLE=YES"
						echo '[splt] -------'
						commands.sh | nc -Nw "$CONNECTION_TIMEOUT" "$TW_HOST" "$i"
				else
						echo "[info] REACHABLE=NO"
						if [ "$ERROR_EXIT" -eq 1 ]
						then
								echo '[error] EXITING...'
								exit 1
						fi
				fi
		done
		echo "[info] Sleeping $INTERVAL second[s]..."
		sleep "$INTERVAL"
done
