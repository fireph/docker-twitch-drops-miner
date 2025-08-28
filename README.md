# docker-twitch-drops-miner

Based on this image: https://github.com/jlesage/docker-baseimage-gui

```
docker build -t dungfu/twitch-drops-miner:latest .
docker push dungfu/twitch-drops-miner:latest
```

Don't forget to mount `/TwitchDropsMiner/settings.json` and `/TwitchDropsMiner/cookies.jar` to have data persistence.

You can also mount `/TwitchDropsMiner/cache` if you want persistence of the cache folder.

Available at: https://hub.docker.com/r/dungfu/twitch-drops-miner

Example Docker Compose:

```yaml
twitch-drops-miner:
  image: dungfu/twitch-drops-miner
  ports:
    - "5800:5800/tcp"
  volumes:
   - /usr/me/tdm/settings.json:/TwitchDropsMiner/settings.json
   - /usr/me/tdm/cookies.jar:/TwitchDropsMiner/cookies.jar
   - /usr/me/tdm/cache:/TwitchDropsMiner/cache
  environment:
    - USER_ID=568
    - GROUP_ID=568
```

See [Environment Variables](https://github.com/jlesage/docker-baseimage-gui?tab=readme-ov-file#environment-variables) for a list of all the supported ones.
