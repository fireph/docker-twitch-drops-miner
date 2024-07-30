# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-22.04-v4

MAINTAINER fireph

# Environment
ENV LANG=en_US.UTF-8
ENV DARK_MODE=1
ENV KEEP_APP_RUNNING=1
ENV TDM_VERSION_TAG v15.8.0
ENV APP_ICON_URL https://raw.githubusercontent.com/Windows200000/TwitchDropsMiner-updated/master/appimage/pickaxe.png

# Install Twitch Drops Miner
RUN apt-get update -y
RUN apt-get install -y wget unzip libc6 gir1.2-appindicator3-0.1 language-pack-en fonts-noto-color-emoji
RUN wget -P /tmp/ https://github.com/Windows200000/TwitchDropsMiner-updated/releases/download/v15.8.0/Twitch.Drops.Miner.Linux.PyInstaller.zip
RUN mkdir /TwitchDropsMiner
RUN unzip -p /tmp/Twitch.Drops.Miner.Linux.PyInstaller.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/TwitchDropsMiner/TwitchDropsMiner
RUN chmod +x /TwitchDropsMiner/TwitchDropsMiner
RUN rm -rf /tmp

# Link config folder files
RUN mkdir /TwitchDropsMiner/config
RUN ln -s /TwitchDropsMiner/config/settings.json /TwitchDropsMiner/settings.json
RUN ln -s /TwitchDropsMiner/config/cookies.jar /TwitchDropsMiner/cookies.jar

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
