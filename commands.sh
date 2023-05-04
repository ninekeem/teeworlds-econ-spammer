#!/bin/sh

echo "$EC_PASSWORD"
CMDS=$(env | grep "^CMD" | sort | sed -e s/'CMD.*_'//)
echo "$CMDS" | while IFS= read -r i
do
		i="${i#CMD*_}"
		if [ "${i%=*}" = "COMMAND" ] 
		then
				echo "${i#COMMAND*=}"
		elif [ "${i%=*}" = "SHELL" ] 
		then
				echo "say $(${i#SHELL*=})"
		fi
done
