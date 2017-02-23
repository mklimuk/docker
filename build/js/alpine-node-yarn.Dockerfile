FROM alpine:3.5

LABEL version="2017-02-16-1"
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && apk update && \
    apk add yarn

WORKDIR /app
