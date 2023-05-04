#!/bin/sh

# ---------- #
# INIT BLOCK #
# ---------- #

# Connection timeout
if [ -z "$CONNECTION_TIMEOUT" ] ; then CONNECTION_TIMEOUT=5; fi
echo "[init] CONNECTION_TIMEOUT=$CONNECTION_TIMEOUT"

# Needed for testing purpose
# DRY=0 cause script to work as usual
# DRY=1 cause script to just show commands, but not to send them on server
if [ -z "$DRY" ] ; then DRY=0 ; fi
echo "[init] DRY=$DRY"

# ECON password
if [ -z "$EC_PASSWORD" ] ; then EC_PASSWORD='password' ; fi
echo "[init] EC_PASSWORD=$EC_PASSWORD"

# Server[s] port[s]
. ec_port.sh
echo "[init] EC_PORT=$EC_PORT"

# Exit if REACHABLE=NO
if [ -z "$ERROR_EXIT" ] ; then ERROR_EXIT=0 ; fi
echo "[init] ERROR_EXIT=$ERROR_EXIT"

# Key for TOGGLE_COMMANDS
# TODO: More powerful key system (maybe)
if [ -z "$INIT_KEY" ] ; then INIT_KEY=1 ; fi
echo "[init] INIT_KEY=$INIT_KEY"

# Spam interval
if [ -z "$INTERVAL" ] ; then INTERVAL=300 ; fi
echo "[init] INTERVAL=$INTERVAL"

# Server IP host
if [ -z "$TW_HOST" ] ; then TW_HOST='127.0.0.1' ; fi
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
