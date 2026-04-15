<div align="center">

![Twitch Drops Miner Icon](https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png)

# Docker Twitch Drops Miner (WebUI)

An unofficial Docker container for automatically mining Twitch drops with a native web-based interface (WebUI).

![Docker Pulls](https://img.shields.io/docker/pulls/dungfu/twitch-drops-miner?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dungfu/twitch-drops-miner?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/dungfu/twitch-drops-miner/webui)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/fireph/docker-twitch-drops-miner/dockerimage-main.yml?style=flat-square)

[![Docker Hub](https://img.shields.io/badge/Open%20On-DockerHub-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/dungfu/twitch-drops-miner)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?style=for-the-badge&logo=github)](https://github.com/fireph/docker-twitch-drops-miner)

</div>

## 📋 Overview

A containerized version of [Twitch Drops Miner](https://github.com/fireph/TwitchDropsMiner) with a native WebUI for easy management directly in your browser.

**Key Benefits:**
- 🌐 Native web interface - works directly in any browser
- 💾 Low memory footprint - uses only ~80MB RAM (vs 500-600MB for the desktop version)
- 🚀 No additional dependencies - just Docker and a browser

> [!IMPORTANT]
> This is an unofficial docker image, **DO NOT** report docker issues to [DevilXD/TwitchDropsMiner](https://github.com/DevilXD/TwitchDropsMiner)

> [!NOTE]
> Looking for the desktop/tkinter version instead? Use the `latest` tag.
>
> See [README.md](README.md) for documentation.

## 🚀 Quick Start

### Docker Run

```bash
docker run -d \
  --name twitch-drops-miner \
  -p 8080:8080 \
  -v /path/to/config:/TwitchDropsMiner/config \
  -v /path/to/cache:/TwitchDropsMiner/cache \
  -e TZ=America/New_York \
  -u 1000:1000 \
  dungfu/twitch-drops-miner:webui
```

### Docker Compose

```yaml
services:
  twitch-drops-miner:
    image: dungfu/twitch-drops-miner:webui
    container_name: twitch-drops-miner
    ports:
      - "8080:8080"
    volumes:
      - /path/to/config:/TwitchDropsMiner/config
      - /path/to/cache:/TwitchDropsMiner/cache
    environment:
      - TZ=America/New_York
    user: "1000:1000"
    restart: unless-stopped
```

## 📁 Volume Mounts

| Path | Description | Required |
|------|-------------|----------|
| `/TwitchDropsMiner/config` | Application settings and configuration | ✅ Yes |
| `/TwitchDropsMiner/cache` | Cache directory for better performance | ⚠️ Recommended |

## 🌐 Access

After starting the container, access the web interface at:
- **URL**: `http://localhost:8080`

No VNC client needed - the WebUI works directly in your browser!

## ⚙️ Environment Variables

### Basic Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `TZ` | Timezone for the container | `UTC` |

> [!NOTE]
> For the WebUI version, do **NOT** use `USER_ID` or `GROUP_ID` environment variables. Instead, use the `-u` flag with Docker run or the `user:` directive in Docker Compose to specify the user/group (as shown in the Quick Start examples).

## 🔧 Configuration

1. **First Run**: Access the web interface using `http://localhost:8080`
2. **Authentication**: Login through the web interface to your Twitch account to generate cookies.jar
3. **Settings**: Modify settings in the Settings tab or in `/TwitchDropsMiner/config/settings.json`

## 🐳 Docker Hub

This image is automatically built and published to Docker Hub:
- **Repository**: [dungfu/twitch-drops-miner](https://hub.docker.com/r/dungfu/twitch-drops-miner)
- **Tags**: `webui`, `webui-16.dev`, `webui-16.dev.{version}`
- **Architectures**: `linux/amd64`, `linux/arm64`

## 🔍 Troubleshooting

### Permissions issues on mounted volumes

If you are running into permissions issues, make sure the user (e.g., uid 1000/gid 1000) has read/write permissions on your mounted directory. If you don't want to worry about users, `chmod -R 777` on your mounted directory will fix the problem as well.

### Cannot connect to Twitch / Login not working

If the app can find channels but fails to connect to streams, or if login resets after entering the token, your DNS-level ad blocker may be the cause.

**AdGuard, Pi-hole, and similar tools** can block `beacon.twitch.tv`, which is required for the app to function correctly. To fix this, whitelist `beacon.twitch.tv` in your ad blocker.

See [issue #38](https://github.com/fireph/docker-twitch-drops-miner/issues/38) for more details.

## 🏗️ Building from Source

```bash
# Clone the repository
git clone https://github.com/fireph/docker-twitch-drops-miner.git
cd docker-twitch-drops-miner

# Build the WebUI image
docker build -f Dockerfile-webui -t dungfu/twitch-drops-miner:webui .

# Run the container
docker run -d -p 8080:8080 dungfu/twitch-drops-miner:webui
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📜 License

This project is licensed under the MIT License.
