#!/bin/sh
# TODO: add more efficient and powerful port parsing

if [ -z "$EC_PORT" ]
then
		EC_PORT=8303
else
		if echo "$EC_PORT" | grep -q ':'
		then
				EC_PORT_START=$(echo "$EC_PORT" | awk -F ':' '{ print $1 }')
				EC_PORT_END=$(echo "$EC_PORT" | awk -F ':' '{ print $2 }')
				EC_PORT=''
				i=$EC_PORT_START
				while [ "$i" -le "$EC_PORT_END" ]
				do
						EC_PORT="$EC_PORT$i "
						i=$((i+1))
				done
		fi
fi
