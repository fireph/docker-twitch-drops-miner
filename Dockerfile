# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

MAINTAINER fireph

# Environment
ENV LANG=en_US.UTF-8
ENV DARK_MODE=1
ENV KEEP_APP_RUNNING=1
ENV TDM_VERSION_TAG=2737936
ENV APP_ICON_URL=https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png

# Install Twitch Drops Miner
RUN apt-get update -y
RUN apt-get install -y wget unzip libc6 gir1.2-appindicator3-0.1 language-pack-en fonts-noto-color-emoji

# Set architecture-specific variables
ARG TARGETARCH
RUN case ${TARGETARCH} in \
      "amd64") ARCH_SUFFIX="x86_64" ;; \
      "arm64") ARCH_SUFFIX="aarch64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -P /tmp/ https://github.com/DevilXD/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.PyInstaller-${ARCH_SUFFIX}.zip && \
    mkdir /TwitchDropsMiner && \
    unzip -p /tmp/Twitch.Drops.Miner.Linux.PyInstaller-${ARCH_SUFFIX}.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/TwitchDropsMiner/TwitchDropsMiner && \
    rm -f /tmp/Twitch.Drops.Miner.Linux.PyInstaller-${ARCH_SUFFIX}.zip
RUN chmod +x /TwitchDropsMiner/TwitchDropsMiner

# Make sure permissions are gonna work
RUN chmod -R 777 /TwitchDropsMiner

# Copy the start script.
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Generate and install favicons
RUN install_app_icon.sh "$APP_ICON_URL"

# Set the name/version of the application.
RUN set-cont-env APP_NAME "Twitch Drops Miner"
RUN set-cont-env APP_VERSION "$TDM_VERSION_TAG"
