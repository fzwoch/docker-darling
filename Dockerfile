FROM debian:buster
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

RUN apt update && apt install -y cmake clang bison flex xz-utils \
    libfuse-dev libudev-dev pkg-config libc6-dev-i386 \
    linux-headers-amd64 libcap2-bin git libcairo2-dev libgl1-mesa-dev \
    libtiff5-dev libfreetype6-dev libxml2-dev libegl1-mesa-dev \
    libfontconfig1-dev libbsd-dev git \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/darlinghq/darling.git \
 && cd darling \
 && git checkout 9fc61ce83101f7005e1bf29cf184a9b4f907d51f \
 && git submodule init \
 && git submodule update \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j $(nproc) \
 && make install \
 && ../../ \
 && rm -rf darling
