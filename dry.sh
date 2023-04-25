#!/bin/sh
# Exception handling
if [ "$DRY" -ne 0 ] && [ "$DRY" -ne 1 ]
then
		echo "DRY=$DRY is not allowed."
		echo "Only 0 or 1 can be used"
		exit 1
fi
