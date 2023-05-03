#!/bin/sh

# Connection timeout
# Used for PERMACONNECT=0
if [ -z "$CONNECT_TIMEOUT" ] ; then CONNECT_TIMEOUT=5; fi


# Needed for testing purpose
# DRY=0 cause script to work as usual
# DRY=1 cause script to just show commands, but not to send them on server
if [ -z "$DRY" ]
then
		DRY=0
else
		. dry.sh
fi
echo "[init]DRY=$DRY"

# ECON password
if [ -z "$EC_PASSWORD" ] ; then EC_PASSWORD='password' ; fi
echo "[init]EC_PASSWORD=$EC_PASSWORD"

# Key for TOGGLE_COMMANDS
# TODO: More powerful key system (maybe)
if [ -z "$INIT_KEY" ] ; then INIT_KEY=1 ; fi
echo "[init]INIT_KEY=$INIT_KEY"

# Spam interval
if [ -z "$INTERVAL" ] ; then INTERVAL=300 ; fi
echo "[init]INTERVAL=$INTERVAL"

# Used to parse output from ECON
# PERMACONNECT=0 cause script to work as usual
# PERMACONNECT=1 cause script to listen server
# TODO: implement this
if [ -z "$PERMACONNECT" ]
then
		PERMACONNECT=0
else
		. permaconnect.sh
fi
echo "[init]PERMACONNECT=$PERMACONNECT"

# Server IP host
if [ -z "$TW_HOST" ] ; then TW_HOST='127.0.0.1' ; fi
echo "[init]TW_HOST=$TW_HOST"

# Server[s] port[s]
. tw_port.sh
echo "[init]TW_PORT=$TW_PORT"

# Execution of all commands and netcat it on server[s]
while true
do
		if env | grep -q "^CMD"
		then
				# If $DRY=1 then just echo $COMMANDS and exit
				if [ "$DRY" -eq 1 ]
				then
						commands.sh
						exit
				fi
				for i in $TW_PORT ; do
						date
						commands.sh | nc -Nw "$CONNECT_TIMEOUT" "$TW_HOST" "$i" || exit 1
				done
		else
				echo 'Looks like you not specified commands. Exiting.'
				exit 1
		fi
		sleep "$INTERVAL"
done
