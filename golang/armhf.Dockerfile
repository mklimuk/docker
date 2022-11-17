FROM golang:1.18-buster

RUN printf '%s\n' 'path-exclude /usr/share/doc/*' 'path-include /usr/share/doc/*/copyright' 'path-exclude /usr/share/man/*' 'path-exclude /usr/share/groff/*' 'path-exclude /usr/share/info/*' 'path-exclude /usr/share/lintian/*' 'path-exclude /usr/share/linda/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && export DEBIAN_FRONTEND=noninteractive && dpkg --add-architecture armhf && apt-get update && \
    apt-get install -yq fakeroot crossbuild-essential-armhf libasound2-dev:armhf liblinphone-dev:armhf

# install mage
RUN cd /go/bin && wget https://github.com/magefile/mage/releases/download/v1.14.0/mage_1.14.0_Linux-ARM.tar.gz -O - | tar -xz && cd /go && mage --version

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

# bootstrap go environment for armhf
RUN CC=arm-linux-gnueabihf-gcc-6 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a" CGO_CXXFLAGS="-march=armv7-a" go install std
