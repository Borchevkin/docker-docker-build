FROM ubuntu:20.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV XDG_CACHE_HOME=/root/.cache
ENV FORCE_UNSAFE_CONFIGURE=1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root/

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        make=4.2.1-1.2 \
        git=1:2.25.1-1ubuntu3.13 \
        wget=1.20.3-1ubuntu2.1 \
        apt-transport-https=2.0.10 \
        ca-certificates=20230311ubuntu0.20.04.1 \ 
        software-properties-common=0.99.9.12 \
        gpg-agent=2.2.19-3ubuntu2.2 \
    && \
    apt-get -y clean && \ 
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN \
    wget --output-document - --quiet https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

RUN \
    apt-get install --no-install-recommends -y \
        docker-ce=5:27.2.0-1~ubuntu.20.04~focal \
        && \
    apt-get -y clean && \ 
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN \
    wget \
        --no-check-certificate \
        --progress=dot:giga \
        -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64 \
    && \
    chmod +x /bin/hadolint