FROM docker.io/library/alpine:latest AS builder
RUN apk --no-cache --update upgrade --ignore alpine-baselayout \
 && apk --no-cache add curl \
 && apk --no-cache add gstreamer-dev gst-plugins-base-dev \
 && apk --no-cache add build-base libnice-dev openssl-dev cargo
COPY . .
RUN cargo build --release -p gst-meet

FROM docker.io/library/alpine:latest
RUN apk --update --no-cache upgrade --ignore alpine-baselayout \
 && apk --no-cache add curl \
 && apk --no-cache add libnice openssl flac \
 && apk --no-cache add gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly libnice-gstreamer gst-libav 
COPY --from=builder target/release/gst-meet /usr/local/bin
ENTRYPOINT ["/usr/local/bin/gst-meet"]