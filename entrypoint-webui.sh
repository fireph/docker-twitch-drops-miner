#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    exec /TwitchDropsMiner/TwitchDropsMiner --stdlog
fi

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}

GROUP_NAME=$(awk -F: -v gid="$GROUP_ID" '$3 == gid {print $1}' /etc/group)
if [ -z "$GROUP_NAME" ]; then
    addgroup -g "$GROUP_ID" -S app
    GROUP_NAME=app
fi

USER_NAME=$(awk -F: -v uid="$USER_ID" '$3 == uid {print $1}' /etc/passwd)
if [ -z "$USER_NAME" ]; then
    adduser -u "$USER_ID" -G "$GROUP_NAME" -S -H -D app
    USER_NAME=app
fi

exec su-exec "$USER_NAME" /TwitchDropsMiner/TwitchDropsMiner --stdlog
