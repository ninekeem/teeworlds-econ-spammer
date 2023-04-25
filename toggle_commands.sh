#!/bin/sh

if env | grep -q "^TOGGLE_CMD"
then
		TOGGLE_CMDS=$(env | grep "^TOGGLE_CMD" | sort | sed -e s/'TOGGLE_CMD.*='//)
		IFS="$(printf '\t')"
		for i in $TOGGLE_CMDS
		do
				TOGGLE_COMMANDS="$TOGGLE_COMMANDS\n$i"
		done
		IFS="$(printf ' ^I\n')"
fi

TOGGLE_COMMANDS=$(printf '%s'"$TOGGLE_COMMANDS")
echo "$TOGGLE_COMMANDS"
