#!/bin/bash

ALL_VERSION=1.19.2
BUILD_DIR=$HOME/build/gst

GSTREAMER_VERSION=$ALL_VERSION
GST_PLUGINS_BASE_VERSION=$ALL_VERSION
GST_PLUGINS_GOOD_VERSION=$ALL_VERSION
GST_PLUGINS_BAD_VERSION=$ALL_VERSION
GST_PLUGINS_UGLY_VERSION=$ALL_VERSION
GST_PYTHON_VERSION=$ALL_VERSION
GST_LIBAV_VERSION=$ALL_VERSION


mkdir -p $BUILD_DIR

# cloner repo for each gstreamer module
echo 'using directory '$BUILD_DIR
cd $BUILD_DIR
git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git && cd gstreamer && git checkout ${GSTREAMER_VERSION} && cd ..
git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-base.git && cd gst-plugins-base && git checkout ${GST_PLUGINS_BASE_VERSION} && cd ..
git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-good && cd gst-plugins-good && git checkout ${GST_PLUGINS_GOOD_VERSION} && cd ..
git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad && cd gst-plugins-bad && git checkout ${GST_PLUGINS_BAD_VERSION} && cd ..
git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-ugly && cd gst-plugins-ugly && git checkout ${GST_PLUGINS_UGLY_VERSION} && cd ..
git clone https://gitlab.freedesktop.org/gstreamer/gst-python && cd gst-python && git checkout ${GST_PYTHON_VERSION} && cd ..

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autopoint \
        autoconf \
        automake \
        autotools-dev \
        libtool \
        gettext \
        bison \
        flex \
        gtk-doc-tools \
        libtool-bin \
        libgtk2.0-dev \
        libgl1-mesa-dev \
        libopus-dev \
        libpulse-dev \
        libgirepository1.0-dev \

# Install meson build deps
apt install -y python3-pip python-gi-dev ninja-build && \
    pip3 install meson



# Build gstreamer
cd $BUILD_DIR/gstreamer && \
    meson build --prefix=/usr/local && \
    ninja -C build install

apt install -y libvorbis-dev libvorbisidec1 libvorbisenc2


# Build gstreamer-base
cd $BUILD_DIR/gst-plugins-base && \
    meson build --prefix=/usr/local && \
    ninja -C build install

# Install deps for gst-plugins-good
DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libvpx-dev \
        libvpx6

# Build gst-plugins-good
cd $BUILD_DIR/gst-plugins-good && \
    meson build --prefix=/usr/local && \
    ninja -C build install

if false; then

# Build gst-instruments from source
GST_INSTRUMENTS_VERSION=0.2.4
cd $BUILD_DIR && \
    git clone https://github.com/kirushyk/gst-instruments.git && \
    cd gst-instruments && git checkout ${GST_INSTRUMENTS_VERSION} && \
    ./autogen.sh --prefix=/usr/local && \
    make -j8 && make install

fi

# Install deps for gst-plugins-bad
DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libwebrtc-audio-processing-dev \
        libssl-dev \
        libsrtp2-dev libusrsctp-dev libnice-dev

if false; then # try to use system packages

# Install usrsctp from source
USRSCTP_VERSION=6ce0f8fe7455e566a6833684ec5983547658856d
cd $BUILD_DIR && git clone https://github.com/sctplab/usrsctp.git && \
    cd usrsctp && git checkout ${USRSCTP_VERSION} && \
    ./bootstrap && ./configure --prefix=/usr/local && \
        make && make install && make clean

fi

apt install -y libssl-dev

# Install libnice from source
cd $BUILD_DIR && git clone https://gitlab.freedesktop.org/libnice/libnice.git && \
    cd libnice && \
    meson build --prefix=/usr/local && \
    ninja -C build install

# Install gst-plugins-bad from source
# Note that the branch being used contains the nvcodec refactor
# that loads the nvidia libraries at runtime, so no existing
# libs need to be present when building the plugin.
# This is the case for gstreamer 1.17+.
cd $BUILD_DIR/gst-plugins-bad && \
    meson build --prefix=/usr/local && \
    ninja -C build install


# Install gst-python from source
cd $BUILD_DIR/gst-python && \
    meson build --prefix=/usr/local \
        -Dpygi-overrides-dir=/usr/local/lib/python3/dist-packages/gi/overrides && \
    ninja -C build install

if false; then

# Install GstShark for latency tracing
GST_SHARK_VERSION=v0.6.1
apt install -y graphviz libgraphviz-dev && \
    cd $BUILD_DIR && \
    git clone --depth 1 https://github.com/RidgeRun/gst-shark -b ${GST_SHARK_VERSION} && \
    cd gst-shark && ./autogen.sh --prefix=/usr/local && \
        make && make install && make clean

fi


# Build and install gst-plugins-ugly from source
# This package includes the x264 encoder for non-nvenc accelerated pipelines.
apt install -y libx264-155 libx264-dev

cd $BUILD_DIR/gst-plugins-ugly && \
    meson build --prefix=/usr/local && \
    ninja -C build install

apt install -y libavfilter-dev

cd $BUILD_DIR && \
    git clone https://gitlab.freedesktop.org/gstreamer/gst-libav && \
    cd gst-libav/ && \
    git checkout $GST_LIBAV_VERSION && \
    meson build --prefix=/usr/local && \
    ninja -C build install
