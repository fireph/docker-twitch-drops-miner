#!/bin/sh

if [ -d "/TwitchDropsMiner/config" ]; then
    chown -R "$(id -u):$(id -g)" /TwitchDropsMiner/config
fi
if [ -d "/TwitchDropsMiner/cache" ]; then
    chown -R "$(id -u):$(id -g)" /TwitchDropsMiner/cache
fi

exec /TwitchDropsMiner/TwitchDropsMiner