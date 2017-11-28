from golang:1.9

RUN printf '%s\n' 'path-exclude /usr/share/doc/*' 'path-include /usr/share/doc/*/copyright' 'path-exclude /usr/share/man/*' 'path-exclude /usr/share/groff/*' 'path-exclude /usr/share/info/*' 'path-exclude /usr/share/lintian/*' 'path-exclude /usr/share/linda/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && export DEBIAN_FRONTEND=noninteractive && \
    echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list && \
    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - && \
    dpkg --add-architecture armhf && apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -yq fakeroot crossbuild-essential-armhf libasound2-dev:armhf webkit2gtk-4.0-dev:armhf javascriptcoregtk-3.0-dev:armhf gir1.2-webkit2-4.0:armhf libgtk-3-dev:armhf libsoup2.4-dev:armhf gir1.2-gtk-3.0:armhf gir1.2-soup-2.4:armhf libgdk-pixbuf2.0-dev:armhf libatk1.0-dev:armhf libatk-bridge2.0-dev:armhf gir1.2-atk-1.0:armhf gir1.2-gdkpixbuf-2.0:armhf libatspi2.0-dev:armhf libglib2.0-dev:armhf

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

# bootstrap go environment for armhf
RUN CC=arm-linux-gnueabihf-gcc-4.9 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a" CGO_CXXFLAGS="-march=armv7-a" go install std
