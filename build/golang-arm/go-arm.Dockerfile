from golang:1.7

RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list && \
    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - && \
    dpkg --add-architecture armhf && apt-get update && \
    apt-get install -y crossbuild-essential-armhf libasound2-dev libasound2-dev:armhf \
    --no-install-recommends

COPY build-arm.sh /usr/bin/build-arm.sh
