# Download stage
FROM alpine:latest as downloader
ARG TARGETARCH
RUN apk add --no-cache ca-certificates wget unzip && \
    case ${TARGETARCH} in \
      "amd64") ARCH_SUFFIX="x86_64" ;; \
      "arm64") ARCH_SUFFIX="aarch64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -P /tmp/ https://github.com/DevilXD/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.PyInstaller-${ARCH_SUFFIX}.zip && \
    unzip -p /tmp/Twitch.Drops.Miner.Linux.PyInstaller-${ARCH_SUFFIX}.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/TwitchDropsMiner && \
    chmod +x /TwitchDropsMiner

# Final image
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

LABEL maintainer="fireph"

# Environment
ENV LANG=en_US.UTF-8
ENV DARK_MODE=1
ENV KEEP_APP_RUNNING=1
ENV TDM_VERSION_TAG=16.dev.2737936
ENV APP_ICON_URL=https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png

# Only install runtime dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    libc6 \
    gir1.2-appindicator3-0.1 \
    language-pack-en \
    fonts-noto-color-emoji && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/log/*

# Copy binary from build stage
COPY --from=downloader /TwitchDropsMiner /TwitchDropsMiner/TwitchDropsMiner
RUN mkdir -p /TwitchDropsMiner && \
    chmod -R 777 /TwitchDropsMiner

# Copy the start script and setup application
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh && \
    install_app_icon.sh "$APP_ICON_URL" && \
    set-cont-env APP_NAME "Twitch Drops Miner" && \
    set-cont-env APP_VERSION "$TDM_VERSION_TAG"
