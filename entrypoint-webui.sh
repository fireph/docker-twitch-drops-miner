#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    exec /TwitchDropsMiner/TwitchDropsMiner --stdlog
fi

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}

addgroup -g "$GROUP_ID" -S app
adduser -u "$USER_ID" -G app -S -H -D app

exec su-exec app /TwitchDropsMiner/TwitchDropsMiner --stdlog
