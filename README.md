<div align="center">

# Docker Twitch Drops Miner

A Docker container for automatically mining Twitch drops with a web-based GUI interface.

[<img src="https://img.shields.io/docker/pulls/dungfu/twitch-drops-miner" alt="Docker Pulls">](https://hub.docker.com/r/dungfu/twitch-drops-miner)
<img src="https://img.shields.io/docker/stars/dungfu/twitch-drops-miner?style=flat-square" alt="Docker Stars">
[<img src="https://img.shields.io/docker/image-size/dungfu/twitch-drops-miner/latest" alt="Docker Image Size">](https://hub.docker.com/r/dungfu/twitch-drops-miner)
[<img src="https://img.shields.io/github/actions/workflow/status/fireph/docker-twitch-drops-miner/dockerimage-main.yml" alt="GitHub Workflow Status">](https://github.com/fireph/docker-twitch-drops-miner/actions)
[<img src="https://img.shields.io/badge/Open%20On-DockerHub-blue?style=for-the-badge&logo=docker" alt="Docker Hub">](https://hub.docker.com/r/dungfu/twitch-drops-miner) [<img src="https://img.shields.io/badge/GitHub-Repository-blue?style=for-the-badge&logo=github" alt="GitHub Repository">](https://github.com/fireph/docker-twitch-drops-miner)

</div>

## 📋 Overview

This project provides a containerized version of [Twitch Drops Miner](https://github.com/DevilXD/TwitchDropsMiner) with a web-based GUI for easy management. It's built on [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) for the web GUI interface.

## 🚀 Quick Start

### Docker Run

```bash
docker run -d \
  --name twitch-drops-miner \
  -p 5800:5800 \
  -v /path/to/settings.json:/TwitchDropsMiner/settings.json \
  -v /path/to/cookies.jar:/TwitchDropsMiner/cookies.jar \
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
      - ./settings.json:/TwitchDropsMiner/settings.json
      - ./cookies.jar:/TwitchDropsMiner/cookies.jar
      - ./cache:/TwitchDropsMiner/cache
    environment:
      - USER_ID=1000
      - GROUP_ID=1000
      - TZ=America/New_York
    restart: unless-stopped
```

## 📁 Volume Mounts

| Path | Description | Required |
|------|-------------|----------|
| `/TwitchDropsMiner/settings.json` | Application settings and configuration | ✅ Yes |
| `/TwitchDropsMiner/cookies.jar` | Twitch authentication cookies | ✅ Yes |
| `/TwitchDropsMiner/cache` | Cache directory for better performance | ⚠️ Recommended |

## 🌐 Access

After starting the container, access the web interface at:
- **URL**: `http://localhost:5800`
- **VNC**: Connect to `localhost:5900` (if VNC access is needed)

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
git clone https://github.com/dungfu/docker-twitch-drops-miner.git
cd docker-twitch-drops-miner

# Build the image
docker build -t dungfu/twitch-drops-miner:latest .

# Run the container
docker run -d -p 5800:5800 dungfu/twitch-drops-miner:latest
```

## 🔧 Configuration

1. **First Run**: Access the web interface and configure your Twitch account
2. **Settings**: Modify `/TwitchDropsMiner/settings.json` for advanced configuration
3. **Authentication**: Login through the web interface to generate cookies.jar

## 🐳 Docker Hub

This image is automatically built and published to Docker Hub:
- **Repository**: [dungfu/twitch-drops-miner](https://hub.docker.com/r/dungfu/twitch-drops-miner)
- **Tags**: `latest` (multi-arch: `linux/amd64`, `linux/arm64`)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📜 License

This project is licensed under the MIT License.
