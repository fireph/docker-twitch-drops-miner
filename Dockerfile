# Download stage
FROM alpine:latest AS downloader
ARG TARGETARCH
RUN apk add --no-cache ca-certificates wget unzip && \
    case ${TARGETARCH} in \
      "amd64") ARCH_SUFFIX="x86_64" ;; \
      "arm64") ARCH_SUFFIX="aarch64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -P /tmp/ https://github.com/fireph/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.AppImage-${ARCH_SUFFIX}.zip && \
    unzip -p /tmp/Twitch.Drops.Miner.Linux.AppImage-${ARCH_SUFFIX}.zip "Twitch Drops Miner/Twitch.Drops.Miner-${ARCH_SUFFIX}.AppImage" >/TwitchDropsMiner && \
    chmod +x /TwitchDropsMiner

# Final image
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

LABEL maintainer="fireph"

# Environment
ENV DARK_MODE=1
ENV KEEP_APP_RUNNING=1
ENV TDM_VERSION_TAG=16.dev.2737936
ENV APP_ICON_URL=https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png

# Setup locale
RUN add-pkg locales && \
    sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

# Install runtime dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    libc6 \
    gir1.2-appindicator3-0.1 \
    fonts-noto-color-emoji && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/log/*

# Copy binary from build stage and link config directory
COPY --from=downloader /TwitchDropsMiner /TwitchDropsMiner/TwitchDropsMiner
RUN mkdir -p /TwitchDropsMiner/config && \
    touch /TwitchDropsMiner/config/settings.json && \
    touch /TwitchDropsMiner/config/cookies.jar && \
    ln -s /TwitchDropsMiner/config/settings.json /TwitchDropsMiner/settings.json && \
    ln -s /TwitchDropsMiner/config/cookies.jar /TwitchDropsMiner/cookies.jar && \
    chmod -R 777 /TwitchDropsMiner

# Copy the start script and setup application
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh && \
    install_app_icon.sh "$APP_ICON_URL" && \
    set-cont-env APP_NAME "Twitch Drops Miner" && \
    set-cont-env APP_VERSION "$TDM_VERSION_TAG"
