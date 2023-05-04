#!/bin/sh
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
