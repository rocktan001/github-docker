ARG BASE_IMAGE=nvidia/opengl:1.2-glvnd-devel-ubuntu20.04
From $BASE_IMAGE

LABEL maintainer "rocktan001"
MAINTAINER tanzhongqiang "https://github.com/rocktan001"

ENV DEBIAN_FRONTEND=noninteractive
ENV UID=1000 \
    GID=1000 \
    TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8

## Remove /etc/apt/sources.list.d/* 
RUN rm -rf /etc/apt/sources.list.d/*

## Install some common tools 
RUN apt-get update  && \
    apt-get install -y sudo vim gedit locales wget curl git gnupg2 lsb-release net-tools iputils-ping mesa-utils \
                    openssh-server bash-completion software-properties-common python3-pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    pip3 install --upgrade pip &&\
    rm -rf /var/lib/apt/lists/* 

## Install desktop
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-terminal xfce4-power-manager xfce4-screensaver fonts-wqy-zenhei &&\
    locale-gen zh_CN.UTF-8

## Install Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&\
    apt-get install -yf ./google-chrome-stable_current_amd64.deb &&\
    rm google-chrome-stable_current_amd64.deb

ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
RUN apt-get install -y pulseaudio && mkdir -p /var/run/dbus

## Install nomachine
RUN curl -fSL "https://www.nomachine.com/free/linux/64/deb" -o nomachine.deb &&\
    dpkg -i nomachine.deb &&\
    rm nomachine.deb &&\
    sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg &&\
    sed -i '/DefaultDesktopCommand/c\DefaultDesktopCommand "/usr/bin/startxfce4"' /usr/NX/etc/node.cfg

## Configure ssh
RUN mkdir /var/run/sshd

## Copy config
COPY docker_config /docker_config

####################################################################################
RUN apt-get install -y dc lsb numactl
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
RUN mkdir -p /usr/tmp/.flexlm
COPY synopsys/libpng12.so.0/libpng12.so.0 /usr/lib/x86_64-linux-gnu/
ADD synopsys/synopsys.tar.gz /
RUN mkdir -p /synopsys/license
COPY synopsys/license/ /synopsys/license/

EXPOSE 22 4000

ENTRYPOINT ["/docker_config/startup.sh"]
