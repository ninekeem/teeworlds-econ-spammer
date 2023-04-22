#!/bin/sh

if [ -z "$EC_PASSWORD" ] ; then EC_PASSWORD='password' ; fi
if [ -z "$INTERVAL" ] ; then INTERVAL=300 ; fi
if [ -z "$TW_HOST" ] ; then TW_HOST='127.0.0.1' ; fi

# TODO: add more efficient and powerful ports parsing
if [ -z "$TW_PORTS" ]
then
		TW_PORTS=8303
else
		if echo "$TW_PORTS" | grep -q '-'
		then
				TW_PORT_START=$(echo "$TW_PORTS" | awk -F '-' '{ print $1 }')
				TW_PORT_END=$(echo "$TW_PORTS" | awk -F '-' '{ print $2 }')
				TW_PORTS=''
				i=$TW_PORT_START
				while [ "$i" -le "$TW_PORT_END" ]
				do
						TW_PORTS="$TW_PORTS$i "
						i=$((i+1))
				done
		fi
fi

if env | grep -q "^CMD"
then
		COMMANDS="$EC_PASSWORD"
		CMDS=$(env | grep "^CMD" | sort | sed -e s/'CMD.*='//)
		IFS="$(printf '\t')"
		for i in $CMDS
		do
				COMMANDS="$COMMANDS\n$i"
		done
		IFS="$(printf ' ^I\n')"
else
		COMMANDS="$EC_PASSWORD\nsay SAMPLE TEXT"
fi

COMMANDS=$(printf '%s'"$COMMANDS")

while true
do
		for i in $TW_PORTS ; do
				echo "$COMMANDS" | nc -N "$TW_HOST" "$i"
		done
		sleep "$INTERVAL"
done
