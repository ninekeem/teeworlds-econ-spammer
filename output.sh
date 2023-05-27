#!/bin/sh

. common_envs.sh

echo "$EC_PASSWORD"
env | grep "CMD" | sort | while IFS= read -r i
do
    i="${i#"$CMD"*_*_}"
    if [ "${i%=*}" = "COMMAND" ] 
    then
    	echo "${i#COMMAND*=}"
    elif [ "${i%=*}" = "SHELL" ] 
    then
        for j in $(${i#SHELL*=})
        do
            echo "say $j"
        done
    	#echo "say $(${i#SHELL*=})"
    fi
done
