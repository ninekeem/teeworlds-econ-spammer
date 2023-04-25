#!/bin/sh
# TODO: add more efficient and powerful port parsing

if [ -z "$TW_PORT" ]
then
		TW_PORT=8303
else
		if echo "$TW_PORT" | grep -q ':'
		then
				TW_PORT_START=$(echo "$TW_PORT" | awk -F ':' '{ print $1 }')
				TW_PORT_END=$(echo "$TW_PORT" | awk -F ':' '{ print $2 }')
				TW_PORT=''
				i=$TW_PORT_START
				while [ "$i" -le "$TW_PORT_END" ]
				do
						TW_PORT="$TW_PORT$i "
						i=$((i+1))
				done
		fi
fi
