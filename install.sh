#!/usr/bin/env bash
set -ex

# Install Twitch Drops Miner
wget -P /home/kasm-user/.local/share/icons/ https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/pickaxe.ico
wget -P /tmp/ https://github.com/DevilXD/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.PyInstaller.zip
mkdir /home/kasm-user/TwitchDropsMiner
unzip -p /tmp/Twitch.Drops.Miner.Linux.PyInstaller.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/home/kasm-user/TwitchDropsMiner/TwitchDropsMiner
chmod +x /home/kasm-user/TwitchDropsMiner/TwitchDropsMiner

# Desktop icon
mkdir /home/kasm-user/Desktop/
echo -e '[Desktop Entry]\nName=Twitch Drops Miner\nComment=AFK mine timed Twitch drops\nExec=/home/kasm-user/TwitchDropsMiner/TwitchDropsMiner\nIcon=/home/kasm-user/.local/share/icons/pickaxe.ico\nTerminal=false\nType=Application\nStartupNotify=true\nCategories=GNOME;GTK;Development;Documentation;\nMimeType=text/plain;' >> /usr/share/applications/twitch-drops-miner.desktop
chmod +x /usr/share/applications/twitch-drops-miner.desktop
cp /usr/share/applications/twitch-drops-miner.desktop /home/kasm-user/Desktop/
chmod +x /home/kasm-user/Desktop/twitch-drops-miner.desktop

# Link config folder
ln -s /home/kasm-user/config/settings.json /home/kasm-user/TwitchDropsMiner/settings.json
ln -s /home/kasm-user/config/cookies.jar /home/kasm-user/TwitchDropsMiner/cookies.jar
ln -s /home/kasm-user/config/cache /home/kasm-user/TwitchDropsMiner/cache

# Cleanup for app layer
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi
