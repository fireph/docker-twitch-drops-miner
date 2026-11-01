#!/bin/sh
set -e

if [ "$(id -u)" -ne 0 ]; then
    exec /TwitchDropsMiner/TwitchDropsMiner --stdlog
fi

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}

GROUP_NAME=$(awk -F: -v gid="$GROUP_ID" '$3 == gid {print $1}' /etc/group)
if [ -z "$GROUP_NAME" ]; then
    groupadd --gid "$GROUP_ID" app
    GROUP_NAME=app
fi

USER_NAME=$(awk -F: -v uid="$USER_ID" '$3 == uid {print $1}' /etc/passwd)
if [ -z "$USER_NAME" ]; then
    useradd --uid "$USER_ID" --gid "$GROUP_NAME" --no-create-home --no-log-init \
        --shell /usr/sbin/nologin app
    USER_NAME=app
fi

exec gosu "$USER_NAME:$GROUP_NAME" /TwitchDropsMiner/TwitchDropsMiner --stdlog
