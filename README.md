<div align="center">

![Twitch Drops Miner Icon](https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png)

# Docker Twitch Drops Miner

An unofficial Docker container for automatically mining Twitch drops with a web-based GUI interface.

![Docker Pulls](https://img.shields.io/docker/pulls/dungfu/twitch-drops-miner?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dungfu/twitch-drops-miner?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/dungfu/twitch-drops-miner/latest)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/fireph/docker-twitch-drops-miner/dockerimage-main.yml?style=flat-square)

[![Docker Hub](https://img.shields.io/badge/Open%20On-DockerHub-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/dungfu/twitch-drops-miner)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?style=for-the-badge&logo=github)](https://github.com/fireph/docker-twitch-drops-miner)

</div>

## 📋 Overview

A containerized version of [Twitch Drops Miner](https://github.com/fireph/TwitchDropsMiner) with a web-based GUI for easy management. It's built on [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) for the web GUI interface.

The app can also run into issues periodically, so restarting the container daily is recommended to make sure mining continues even if an error occurs.

> [!IMPORTANT]
> This is an unofficial docker image, **DO NOT** report docker issues to [DevilXD/TwitchDropsMiner](https://github.com/DevilXD/TwitchDropsMiner)

## 🚀 Quick Start

### Docker Run

```bash
docker run -d \
  --name twitch-drops-miner \
  -p 5800:5800 \
  -v /path/to/config:/TwitchDropsMiner/config \
  -v /path/to/cache:/TwitchDropsMiner/cache \
  -e USER_ID=1000 \
  -e GROUP_ID=1000 \
  -e TZ=America/New_York \
  dungfu/twitch-drops-miner:latest
```

### Docker Compose

```yaml
services:
  twitch-drops-miner:
    image: dungfu/twitch-drops-miner:latest
    container_name: twitch-drops-miner
    ports:
      - "5800:5800"
    volumes:
      - /path/to/config:/TwitchDropsMiner/config
      - /path/to/cache:/TwitchDropsMiner/cache
    environment:
      - USER_ID=1000
      - GROUP_ID=1000
      - TZ=America/New_York
    restart: unless-stopped
```

## 📁 Volume Mounts

| Path | Description | Required |
|------|-------------|----------|
| `/TwitchDropsMiner/config` | Application settings and configuration | ✅ Yes |
| `/TwitchDropsMiner/cache` | Cache directory for better performance | ⚠️ Recommended |

> [!IMPORTANT]  
> If you are running into permissions issues, make sure the user (default: uid 1000/gid 1000) has read/write permissions on your mounted directory. If you don't want to worry about users, `chmod -R 777` on your mounted directory will fix the problem as well.

## 🌐 Access

After starting the container, access the web interface at:
- **URL**: `http://localhost:5800`
- **VNC**: `localhost:5900` (if VNC access is needed)

## ⚙️ Environment Variables

### Basic Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `USER_ID` | User ID for file permissions | `1000` |
| `GROUP_ID` | Group ID for file permissions | `1000` |
| `TZ` | Timezone for the container | `UTC` |

For a complete list of supported environment variables, see the [base image documentation](https://github.com/jlesage/docker-baseimage-gui#environment-variables).

## 🏗️ Building from Source

```bash
# Clone the repository
git clone https://github.com/fireph/docker-twitch-drops-miner.git
cd docker-twitch-drops-miner

# Build the image
docker build -t dungfu/twitch-drops-miner:latest .

# Run the container
docker run -d -p 5800:5800 dungfu/twitch-drops-miner:latest
```

## 🔧 Configuration

1. **First Run**: Access the web interface using `http://localhost:5800`
2. **Authentication**: Login through the web interface to your Twitch account to generate cookies.jar
3. **Settings**: Modify settings in the Settings tab or in `/TwitchDropsMiner/config/settings.json`

## 🐳 Docker Hub

This image is automatically built and published to Docker Hub:
- **Repository**: [dungfu/twitch-drops-miner](https://hub.docker.com/r/dungfu/twitch-drops-miner)
- **Tags**: `latest`, `16.dev`, `16.dev.{version}`
- **Architectures**: `linux/amd64`, `linux/arm64`, `linux/386`, `linux/arm/v7`, `linux/arm/v6`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📜 License

This project is licensed under the MIT License.
