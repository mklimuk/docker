FROM golang:1.21

ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

RUN printf '%s\n' 'path-exclude /usr/share/doc/*' 'path-include /usr/share/doc/*/copyright' 'path-exclude /usr/share/man/*' 'path-exclude /usr/share/groff/*' 'path-exclude /usr/share/info/*' 'path-exclude /usr/share/lintian/*' 'path-exclude /usr/share/linda/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && export DEBIAN_FRONTEND=noninteractive && apt-get update && \
    apt-get install -yq git-core fakeroot build-essential libasound2-dev liblinphone-dev libgtk-3-dev libwebkit2gtk-4.0-dev curl
    
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -yq nodejs
RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest

# install mage
RUN cd /go/bin && wget https://github.com/magefile/mage/releases/download/v1.15.0/mage_1.15.0_Linux-64bit.tar.gz -O - | tar -xz && cd /go && mage --version

