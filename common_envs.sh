#!/bin/sh

# Condition mode
CONDITION_MODE=${CONDITION_MODE:-default}

# Connection timeout for netcat
CONNECTION_TIMEOUT=${CONNECTION_TIMEOUT:-3}

# !!! DO NOTHING AT THIS TIME !!!
# Needed for testing purpose
# DRY=0 cause script to work as usual
# DRY=1 cause script to just show commands, but not to send them on server
DRY=${DRY:-0}

# ECON password
EC_PASSWORD=${EC_PASSWORD:-password}

# Spam interval
INTERVAL="${INTERVAL:-300}"

# Mode selector
MODE=${MODE:-condition}

# For multiline output
MULTILINE=${MULTILINE:-0}

# Host IP
TW_HOST=${TW_HOST:-127.0.0.1}
