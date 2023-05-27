#!/bin/sh

# ---------- #
# INIT BLOCK #
# ---------- #

. common_envs.sh

echo "[init] MODE=$MODE"

if [ "$MODE" = "spammer" ]
then
    . spammer_envs.sh
    echo "[init] CONNECTION_TIMEOUT=$CONNECTION_TIMEOUT"
    echo "[init] ERROR_EXIT=$ERROR_EXIT"
    echo "[init] INTERVAL=$INTERVAL"
elif [ "$MODE" = "condition" ]
then
    . condition_envs.sh
fi

echo "[init] DRY=$DRY"
echo "[init] EC_PASSWORD=$EC_PASSWORD"
echo "[init] EC_PORT=$EC_PORT"
echo "[init] TW_HOST=$TW_HOST"

if [ -n "$TZ" ]
then
	echo "[init] TZ=$TZ"
	cp /usr/share/zoneinfo/"$TZ" /etc/localtime
	echo "$TZ" > /etc/timezone
fi
VERSION=0.0.1
echo "[init] VERSION=$VERSION"

if [ "$DRY" = '1' ]
then
    exit 0
fi

# --------------- #
# EXECUTION BLOCK #
# --------------- #

# Spammer mode
# NetCat commands on server and sleep after it
echo '[exec] And here we go...'
if [ "$MODE" = "spammer" ]
then
    spammer.sh
    echo "[info] Sleeping $INTERVAL second[s]..."
    sleep "$INTERVAL"

# Condition mode
# Listens server
# NetCat commands on server then condition satisfied
elif [ "$MODE" = "condition" ]
then
    # Specify string as condition
    condition.sh "$CONDITION"
fi
