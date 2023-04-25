#!/bin/sh

CMDS=$(env | grep "^CMD" | sort | sed -e s/'CMD.*_'//)
echo "$CMDS" | while IFS= read -r i
do
		if echo "$i" | grep -q "COMMAND"
		then
				i=$(echo "$i" | sed -e s/'COMMAND.*='//)
				echo "$i"

		elif echo "$i" | grep -q "SHELL"
		then
				i=$(echo "$i" | sed -e s/'SHELL.*='//)
				echo "say $($i)"
		fi
done
