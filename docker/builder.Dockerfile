FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

RUN --mount=type=cache,target=/var/cache/apt \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update \
 && apt-get install -y \
    build-essential \
    ca-certificates \
    checkinstall \
    g++ \
    git \
    gpg \
    libeigen3-dev \
    libssl-dev \
    libtbb-dev \
    python3-dev \
    unzip \
    wget \
 && wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
 && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
 && apt-get update \
 && rm /usr/share/keyrings/kitware-archive-keyring.gpg \
 && apt-get install -y kitware-archive-keyring \
 && apt-get update \
 && apt-get install -y cmake \
 && rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/cuda-12.1/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda-12.1/lib64:$LD_LIBRARY_PATH

WORKDIR /workspace
VOLUME /workspace
