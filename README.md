<div align="center">

![Twitch Drops Miner Icon](https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png)

# Docker Twitch Drops Miner

An unofficial Docker container for automatically mining Twitch drops with a native web-based interface.

[![GitHub Stars](https://img.shields.io/github/stars/fireph/docker-twitch-drops-miner?style=for-the-badge&color=gold&logo=github&logoColor=white)](https://github.com/fireph/docker-twitch-drops-miner/stargazers)

![Docker Pulls](https://img.shields.io/docker/pulls/dungfu/twitch-drops-miner?style=for-the-badge&logo=docker)
![Docker Stars](https://img.shields.io/docker/stars/dungfu/twitch-drops-miner?style=for-the-badge&logo=docker)
![Docker Image Size](https://img.shields.io/docker/image-size/dungfu/twitch-drops-miner/latest?style=for-the-badge&logo=docker)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/fireph/docker-twitch-drops-miner/dockerimage-main.yml?style=for-the-badge&logo=workflow&logoColor=white)

[![Docker Hub](https://img.shields.io/badge/Open%20On-DockerHub-7d46ff?style=for-the-badge&logo=docker)](https://hub.docker.com/r/dungfu/twitch-drops-miner)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-7d46ff?style=for-the-badge&logo=github)](https://github.com/fireph/docker-twitch-drops-miner)
[![Latest Release](https://img.shields.io/github/v/release/fireph/docker-twitch-drops-miner?style=for-the-badge&logo=github&logoColor=white&color=7d46ff&label=Latest%20Release)](https://github.com/fireph/docker-twitch-drops-miner/releases/latest)

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
> Looking for the desktop/tkinter version instead? Use the `tkinter` tag.
>
> See [README-tkinter.md](README-tkinter.md) for documentation.

## 🚀 Quick Start

### Docker Run

```bash
docker run -d \
  --name twitch-drops-miner \
  -p 5800:5800 \
  -u 1000:1000 \
  -v /path/to/config:/TwitchDropsMiner/config \
  -v /path/to/cache:/TwitchDropsMiner/cache \
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
    user: "1000:1000"
    volumes:
      - /path/to/config:/TwitchDropsMiner/config
      - /path/to/cache:/TwitchDropsMiner/cache
    environment:
      - TZ=America/New_York
    restart: unless-stopped
```

## 📁 Volume Mounts

| Path | Description | Required |
|------|-------------|----------|
| `/TwitchDropsMiner/config` | Application settings and configuration | ✅ Yes |
| `/TwitchDropsMiner/cache` | Cache directory for better performance | ⚠️ Recommended |

## 🌐 Access

After starting the container, access the web interface at:
- **HTTP**: `http://localhost:5800`
- **HTTPS** (with `SECURE_CONNECTION=1`): `https://localhost:5800`

No VNC client needed - the WebUI works directly in your browser!

## ⚙️ Environment Variables

### Basic Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `TZ` | Timezone for the container | `UTC` |
| `WEBUI_HOST` | Host address the web UI binds to | `0.0.0.0` |
| `WEBUI_PORT` | Port the web UI listens on | `5800` |
| `WEBUI_AUTH` | Enable authentication for the web UI (`0` = disabled, `1` = enabled)<br>See [Authentication](#authentication) | `0` |
| `SECURE_CONNECTION` | Enable HTTPS (`0` = disabled, `1` = enabled)<br>See [Security](#-security) | `0` |
| `USER_ID` | User ID for file permissions (fallback, see below) | `1000` |
| `GROUP_ID` | Group ID for file permissions (fallback, see below) | `1000` |

### User and File Permissions

The recommended way to set the user/group for the container is using Docker's `--user` / `user` option (e.g., `-u 1000:1000` in `docker run` or `user: "1000:1000"` in Docker Compose). This runs the container as a non-root user from the start, which is more secure and avoids the need for the entrypoint to create a user at runtime.

The `USER_ID` and `GROUP_ID` environment variables are a fallback mechanism for backward compatibility. They are only used when the container runs as root (i.e., without `--user`), in which case the entrypoint creates a user/group with the specified IDs and drops privileges to that user before starting the application. If you use `--user`, these variables are ignored.

## 🔧 Configuration

1. **First Run**: Access the web interface using `http://localhost:5800`
2. **Authentication**: Login through the web interface to your Twitch account to generate cookies.jar
3. **Settings**: Modify settings in the Settings tab or in `/TwitchDropsMiner/config/settings.json`

## 🐳 Docker Hub

This image is automatically built and published to Docker Hub:
- **Repository**: [dungfu/twitch-drops-miner](https://hub.docker.com/r/dungfu/twitch-drops-miner)
- **Tags**: `latest`, `16.dev`, `16.dev.{version}`
- **Architectures**: `linux/amd64`, `linux/arm64`

## 🔍 Troubleshooting

### Permissions issues on mounted volumes

If you are running into permissions issues, make sure the user (e.g., uid 1000/gid 1000) has read/write permissions on your mounted directory. The recommended approach is to pass `-u <uid>:<gid>` to `docker run` (or `user: "<uid>:<gid>"` in Docker Compose) to match the host user. If you don't want to worry about users, `chmod -R 777` on your mounted directory will fix the problem as well.

### Reverse proxy and WebSocket support

The web interface uses WebSockets. If you are running behind a reverse proxy, make sure WebSocket connections are forwarded properly.

**HAProxy** — add the following to your frontend/backend section:

```
option http-server-close
timeout tunnel 1h
```

`option http-server-close` allows HAProxy to detect the `Upgrade: websocket` header and switch to tunnel mode, and `timeout tunnel 1h` prevents the proxy from closing long-lived WebSocket connections prematurely.

**Nginx** — ensure your location block includes:

```nginx
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_read_timeout 1h;
```

The `Upgrade` and `Connection` headers enable the WebSocket handshake, and `proxy_read_timeout 1h` prevents the proxy from closing long-lived WebSocket connections prematurely.

### Cannot connect to Twitch / Login not working

If the app can find channels but fails to connect to streams, or if login resets after entering the token, your DNS-level ad blocker may be the cause.

**AdGuard, Pi-hole, and similar tools** can block `beacon.twitch.tv`, which is required for the app to function correctly. To fix this, whitelist `beacon.twitch.tv` in your ad blocker.

See [issue #38](https://github.com/fireph/docker-twitch-drops-miner/issues/38) for more details.

## 🔒 Security

### HTTPS Support

The WebUI can be served over HTTPS by setting `SECURE_CONNECTION=1`. When enabled:

- Certificates are read from `config/certs/`:
  - `web-privkey.pem` — Web server's private key
  - `web-fullchain.pem` — Web server's certificate, bundled with any root and intermediate certificates
- If either file is missing, a **self-signed certificate** is automatically generated and written to those paths
- Self-signed certificates include `localhost` and `127.0.0.1` as Subject Alternative Names, plus the container hostname and its resolved IP when running in Docker with `--hostname`

To use your own certificates, place your certificate files at `/path/to/config/certs/web-privkey.pem` and `/path/to/config/certs/web-fullchain.pem`.

### Authentication

The WebUI supports basic authentication via `WEBUI_AUTH=1`. When enabled, a username and password are required to access the interface. For maximum security, use both HTTPS and authentication together.

## 🏗️ Building from Source

```bash
# Clone the repository
git clone https://github.com/fireph/docker-twitch-drops-miner.git
cd docker-twitch-drops-miner

# Build the image
docker build -f Dockerfile.webui -t dungfu/twitch-drops-miner:latest .

# Run the container
docker run -d -p 5800:5800 dungfu/twitch-drops-miner:latest
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📜 License

This project is licensed under the MIT License.

## 💫 Star History

<div align="center">
<a href="https://www.star-history.com/?repos=fireph%2Fdocker-twitch-drops-miner&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=fireph/docker-twitch-drops-miner&type=date&theme=dark&legend=top-left&sealed_token=p51kvU4Kkjm1j1A5mZNee7gSl2sR48eXpFKqVftMs3vED-jQMkdoRS4LqdR-xiO1q3krODERVH29TIuzi8Z_dB0uS6HIQGzwF1CLUn40QqwiBhadNs9U0JfvjqYkZI4ppjnC5u07G2uiL6e3i6K7cuwXOrxB8vQ4OQEZm2Fl0uvDrv2E4Fp38EioMNBk" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=fireph/docker-twitch-drops-miner&type=date&legend=top-left&sealed_token=p51kvU4Kkjm1j1A5mZNee7gSl2sR48eXpFKqVftMs3vED-jQMkdoRS4LqdR-xiO1q3krODERVH29TIuzi8Z_dB0uS6HIQGzwF1CLUn40QqwiBhadNs9U0JfvjqYkZI4ppjnC5u07G2uiL6e3i6K7cuwXOrxB8vQ4OQEZm2Fl0uvDrv2E4Fp38EioMNBk" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=fireph/docker-twitch-drops-miner&type=date&legend=top-left&sealed_token=p51kvU4Kkjm1j1A5mZNee7gSl2sR48eXpFKqVftMs3vED-jQMkdoRS4LqdR-xiO1q3krODERVH29TIuzi8Z_dB0uS6HIQGzwF1CLUn40QqwiBhadNs9U0JfvjqYkZI4ppjnC5u07G2uiL6e3i6K7cuwXOrxB8vQ4OQEZm2Fl0uvDrv2E4Fp38EioMNBk" />
 </picture>
</a>
</div>
