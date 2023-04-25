#!/bin/sh

CMDS=$(env | grep "^CMD" | sort | sed -e s/'CMD.*_'//)
echo "$CMDS" | while IFS= read -r i
do
		if echo "$i" | grep -q "COMMAND"
		then
				i=$(echo "$i" | sed -e s/'COMMAND.*='//)
				#printf '%s'"$i\n"
				echo "$i"

		elif echo "$i" | grep -q "SHELL"
		then
				i=$(echo "$i" | sed -e s/'SHELL.*='//)
				#printf '%s'"say $($i)\n"
				echo "say $($i)"
		fi
done
