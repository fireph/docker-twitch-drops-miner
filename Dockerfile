FROM kasmweb/desktop:1.14.0

RUN \
  echo "**** install twitch drop miner app image ****" && \
  wget -P /home/kasm-user/.local/share/icons/ https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/pickaxe.ico && \
  wget -P /tmp/ https://github.com/DevilXD/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.PyInstaller.zip && \
  mkdir /home/kasm-user/.local/TwitchDropsMiner && \
  unzip -p /tmp/Twitch.Drops.Miner.Linux.PyInstaller.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/home/kasm-user/.local/TwitchDropsMiner/TwitchDropsMiner && \
  chmod +x /home/kasm-user/.local/TwitchDropsMiner/TwitchDropsMiner && \
  mkdir /home/kasm-user/Desktop && \
  echo '[Desktop Entry]\nName=Twitch Drops Miner\nComment=AFK mine timed Twitch drops\nExec=/home/kasm-user/.local/TwitchDropsMiner/TwitchDropsMiner\nIcon=/home/kasm-user/.local/share/icons/pickaxe.ico\nTerminal=false\nType=Application\nStartupNotify=true\nCategories=GNOME;GTK;Development;Documentation;\nMimeType=text/plain;' >> /home/kasm-user/Desktop/twitch-drops-miner.desktop && \
  chmod +x /home/kasm-user/Desktop/twitch-drops-miner.desktop && \
  ln -s /home/kasm-user/.local/config/settings.json /home/kasm-user/.local/TwitchDropsMiner/settings.json && \
  ln -s /home/kasm-user/.local/config/cookies.jar /home/kasm-user/.local/TwitchDropsMiner/cookies.jar && \
  ln -s /home/kasm-user/.local/config/cache /home/kasm-user/.local/TwitchDropsMiner/cache && \
  # echo '#!/bin/bash\nsleep 10\nnohup sh -c /home/kasm-user/.local/TwitchDropsMiner/TwitchDropsMiner &' >> /home/kasm-user/startup.sh && \
  # chmod +x /home/kasm-user/startup.sh && \
  echo "**** cleanup ****" && \
  rm -rf /tmp/*

# CMD ["/usr/bin/bash", "/home/kasm-user/startup.sh"]

# ports and volumes
EXPOSE 6901
