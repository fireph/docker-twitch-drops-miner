# Download stage
FROM alpine:latest AS downloader
ARG TARGETARCH
ARG TARGETVARIANT
RUN apk add --no-cache ca-certificates wget unzip && \
    case ${TARGETARCH} in \
      "amd64") ARCH_SUFFIX="x86_64" ;; \
      "arm64") ARCH_SUFFIX="aarch64" ;; \
      "386") ARCH_SUFFIX="i386" ;; \
      "arm") case ${TARGETVARIANT} in \
            "v7") ARCH_SUFFIX="armv7" ;; \
            "v6") ARCH_SUFFIX="armv6" ;; \
            *) echo "Unsupported ARM variant: ${TARGETVARIANT}" && exit 1 ;; \
            esac ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -P /tmp/ https://github.com/fireph/TwitchDropsMiner/releases/download/dev-build/Twitch.Drops.Miner.Linux.musl.PyInstaller-${ARCH_SUFFIX}.zip && \
    unzip -p /tmp/Twitch.Drops.Miner.Linux.musl.PyInstaller-${ARCH_SUFFIX}.zip "Twitch Drops Miner/Twitch Drops Miner (by DevilXD)" >/TwitchDropsMiner && \
    chmod +x /TwitchDropsMiner

# Final image
FROM jlesage/baseimage-gui:alpine-3.22-v4

LABEL maintainer="fireph"

# Environment
ENV ENABLE_CJK_FONT=1
ENV DARK_MODE=1
ENV KEEP_APP_RUNNING=1
ENV TDM_VERSION_TAG=16.dev.378b59b
ENV APP_ICON_URL=https://raw.githubusercontent.com/DevilXD/TwitchDropsMiner/master/appimage/pickaxe.png

# Copy fonts needed for emojis
COPY ./fonts/ /usr/share/fonts/

# Install runtime dependencies
RUN apk add --no-cache \
    ca-certificates \
    fontconfig \
    font-dejavu \
    brotli-libs \
    libx11 \
    libxrender && \
    fc-cache -fv

# Copy binary from build stage
COPY --from=downloader /TwitchDropsMiner /TwitchDropsMiner/TwitchDropsMiner
RUN chmod -R 777 /TwitchDropsMiner

# Copy the start script and setup application
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh && \
    install_app_icon.sh "$APP_ICON_URL" && \
    set-cont-env APP_NAME "Twitch Drops Miner" && \
    set-cont-env APP_VERSION "$TDM_VERSION_TAG"
