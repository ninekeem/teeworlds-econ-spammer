#!/bin/sh

. common_envs.sh
. spammer_envs.sh

# Return 1 if there's no CMDs
if ! env | grep -q "^SPAMMER"
then
    echo "Looks like you didn't specify commands. Exiting."
    exit 1
fi

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
		output.sh SPAMMER | nc -Nw "$CONNECTION_TIMEOUT" "$TW_HOST" "$i"
	else
		echo "[info] REACHABLE=NO"
		if [ "$ERROR_EXIT" -eq 1 ]
		then
			echo '[error] EXITING...'
		    exit 1
			fi
		fi
done
