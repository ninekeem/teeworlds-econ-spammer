#!/bin/sh

# !!! DO NOTHING AT THIS TIME !!!
# Needed for testing purpose
# DRY=0 cause script to work as usual
# DRY=1 cause script to just show commands, but not to send them on server
DRY=${DRY:-0}

# ECON password
EC_PASSWORD=${EC_PASSWORD:-password}

# Exit if REACHABLE=NO
ERROR_EXIT=${ERROR_EXIT:-0}

# Mode selector
MODE=${MODE:-condition}

# Host IP
TW_HOST=${TW_HOST:-127.0.0.1}
