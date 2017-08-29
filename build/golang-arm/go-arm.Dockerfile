from golang:1.7

RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list && \
    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - && \
    dpkg --add-architecture armhf && apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends crossbuild-essential-armhf libasound2-dev:armhf libwebkit2gtk-3.0-dev:armhf && \
    apt-get install -y --no-install-recommends libasound2-dev libwebkit2gtk-3.0-dev libgtk-3-dev libsoup2.4-dev gir1.2-webkit2-3.0 gir1.2-gtk-3.0 gir1.2-soup-2.4 \
    libgdk-pixbuf2.0-dev libatk1.0-dev libatk-bridge2.0-dev libxi-dev gir1.2-atk-1.0 gir1.2-gdkpixbuf-2.0 libatspi2.0-dev

COPY build-arm.sh /usr/bin/build-arm.sh
