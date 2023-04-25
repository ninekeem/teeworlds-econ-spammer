#!/bin/sh
awk "BEGIN { srand(); print int(rand()*$MUL) }" /dev/null
