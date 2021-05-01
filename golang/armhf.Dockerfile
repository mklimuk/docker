FROM golang:1.16

RUN printf '%s\n' 'path-exclude /usr/share/doc/*' 'path-include /usr/share/doc/*/copyright' 'path-exclude /usr/share/man/*' 'path-exclude /usr/share/groff/*' 'path-exclude /usr/share/info/*' 'path-exclude /usr/share/lintian/*' 'path-exclude /usr/share/linda/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && export DEBIAN_FRONTEND=noninteractive && dpkg --add-architecture armhf && apt-get update && \
    apt-get install -yq fakeroot crossbuild-essential-armhf libasound2-dev:armhf

# install mage
RUN pushd /go/bin && wget https://github.com/magefile/mage/releases/download/v1.11.0/mage_1.11.0_Linux-64bit.tar.gz -O - | tar -xz && popd && mage --version

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

# bootstrap go environment for armhf
RUN CC=arm-linux-gnueabihf-gcc-8 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a" CGO_CXXFLAGS="-march=armv7-a" go install std
