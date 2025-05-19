FROM golang:1.23.0-bookworm

RUN printf '%s\n' 'path-exclude /usr/share/doc/*' 'path-include /usr/share/doc/*/copyright' 'path-exclude /usr/share/man/*' 'path-exclude /usr/share/groff/*' 'path-exclude /usr/share/info/*' 'path-exclude /usr/share/lintian/*' 'path-exclude /usr/share/linda/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && export DEBIAN_FRONTEND=noninteractive && dpkg --add-architecture armhf && apt-get update && \
    apt-get install -yq fakeroot crossbuild-essential-armhf libudev-dev libgtk-3-dev libwebkit2gtk-4.0-dev npm

ARG GITHUB_TOKEN
RUN echo "machine github.com login mklimuk password $GITHUB_TOKEN" > /root/.netrc
# install mage
RUN cd /go/bin && wget https://github.com/magefile/mage/releases/download/v1.15.0/mage_1.15.0_Linux-ARM.tar.gz -O - | tar -xz && cd /go && mage --version
# install wails
RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

# bootstrap go environment for armhf
RUN CC=arm-linux-gnueabihf-gcc-12 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a+fp" CGO_CXXFLAGS="-march=armv7-a+fp" go install std
