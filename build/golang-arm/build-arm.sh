echo "Bootstrapping linux/arm-7..."
CC=arm-linux-gnueabihf-gcc-4.9 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a" CGO_CXXFLAGS="-march=armv7-a" go install std

echo "Compiling for linux/arm-7..."
export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
CC=arm-linux-gnueabihf-gcc-4.9 CXX=arm-linux-gnueabihf-g++-4.9 GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CGO_CFLAGS="-march=armv7-a -fPIC" CGO_CXXFLAGS="-march=armv7-a -fPIC" go build -v -x --ldflags="-v" -o "$1" $2

echo "Cleaning up Go runtime for linux/arm-7..."
rm -rf /usr/local/go/pkg/linux_arm
