# docker-twitch-drops-miner

Based on this image: https://github.com/jlesage/docker-baseimage-gui

```
docker build -t dungfu/twitch-drops-miner:latest .
docker push dungfu/twitch-drops-miner:latest
```

Don't forget to mount `/TwitchDropsMiner/config` to have data persistence.

Available at: https://hub.docker.com/r/dungfu/twitch-drops-miner
