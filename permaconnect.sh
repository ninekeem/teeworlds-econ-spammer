#!/bin/sh
# Exception handling
if [ "$PERMACONNECT" -ne 0 ] && [ "$PERMACONNECT" -ne 1 ]
then
		echo "PERMACONNECT=$PERMACONNECT is not allowed."
		echo "Only 0 or 1 can be used"
		exit 1
fi
