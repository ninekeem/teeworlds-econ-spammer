#!/bin/sh

. common_envs.sh

env | grep "^CMD" | sort | while IFS= read -r i
do
    i="${i#"$CMD"*_*_}"
    if [ "${i%=*}" = "COMMAND" ] 
    then
        echo "${i#COMMAND*=}"
    elif [ "${i%=*}" = "SHELL" ] 
    then
        if [ "$MULTILINE" -eq 0 ]
        then
    	    echo "say $(${i#SHELL*=*})"
        else
            for j in $(${i#SHELL*=})
            do
                echo "say $j"
            done
        fi
    fi
done
