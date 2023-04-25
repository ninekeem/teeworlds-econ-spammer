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

# Server commands to be executed
# TODO: Use source
# TODO: Test it out in various scenarios
# TODO: More powerful shell system
if env | grep -q "^CMD"
then
		#. commands.sh
		COMMANDS=$(commands.sh)
fi

# Merging EC_PASSWORD and COMMANDS
COMMANDS=$(printf '%s'"$EC_PASSWORD\n$COMMANDS")

# If $DRY=1 then just echo $COMMANDS and exit
if [ "$DRY" -eq 1 ]
then
		echo "$COMMANDS"
		exit
fi

# Execution of all commands and netcat it on server[s]
while true
do
		# TODO: implement this
		#if env | grep -q "^TOGGLE_CMD"
		#then		
		#		TOGGLE_COMMANDS=$(toggle_commands.sh)
		#fi
		for i in $TW_PORT ; do
				date
				echo "$COMMANDS" | nc -Nw "$CONNECT_TIMEOUT" "$TW_HOST" "$i"
		done
		sleep "$INTERVAL"
done
