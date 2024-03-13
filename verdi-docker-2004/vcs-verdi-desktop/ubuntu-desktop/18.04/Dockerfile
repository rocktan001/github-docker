ARG BASE_IMAGE=nvidia/opengl:1.2-glvnd-devel-ubuntu18.04
From $BASE_IMAGE

LABEL maintainer "zhengpeng ge"
MAINTAINER zhenpeng ge "https://github.com/gezp"

RUN mv /etc/apt/sources.list /etc/apt/sources_backup.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic universe " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates universe " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic multiverse " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates multiverse " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security universe " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security multiverse " >> /etc/apt/sources.list && \
    echo "deb http://archive.canonical.com/ubuntu bionic partner " >> /etc/apt/sources.list

RUN apt-get update

# 使用上海时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata

RUN apt-get install -y \
    git \
    software-properties-common \
    python3.8 \
    sudo \
    fuseext2 \
    telnet \
    rsync \
    gettext \
    dosfstools \
    cpio


RUN dpkg --add-architecture i386
RUN apt-get update

RUN add-apt-repository main && \
    add-apt-repository universe && \
    add-apt-repository restricted && \
    add-apt-repository multiverse && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y

RUN apt-get install -y \
vim \
vim-gtk \
pciutils \ 
git \
gedit \
gitk \
tig \
silversearcher-ag \
subversion \
lrzsz \
ctags \
cscope \
acpica-tools \
bc \
bison \
build-essential \
curl \
flex \
g++-multilib \
gcc-multilib \
gcc-6 \
g++-6 \
genext2fs \
gperf \
libc6:i386 \
libssl-dev \
libstdc++6:i386 \
libncurses5:i386 \
libxml2 \
libxml2-dev \
libxml2-utils \
libxml-libxml-perl \
make \
openssh-server \
openssh-client \
expect \
bridge-utils \
python \
python-pip \
device-tree-compiler \
autopoint \
doxygen \
xterm \
ninja-build \
python3-distutils \
uuid-dev \
wget \
zlib1g:i386 \
zlib1g-dev:i386 \
zip \
mtools \
fuseext2 \
autoconf \
locales \
sbsigntool \
pkg-config \
gdisk \
libnuma-dev \
lsb-core


ENV DEBIAN_FRONTEND=noninteractive
ENV USER=ubuntu \
    PASSWORD=ubuntu \
    UID=1000 \
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
    apt-get install -y xfce4 xfce4-terminal xfce4-power-manager fonts-wqy-zenhei &&\
    locale-gen zh_CN.UTF-8

# Install Chrome
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
RUN mkdir /var/run/sshd &&  \
    echo 'root:THEPASSWORDYOUCREATED' | chpasswd && \
    sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

## Copy config
COPY docker_config /docker_config

## Copy 
COPY libpng12.so.0/libpng12.so.0 /usr/lib/x86_64-linux-gnu/libpng12.so.0
RUN mkdir /usr/tmp  && chmod 777 /usr/tmp

EXPOSE 22 4000

ENTRYPOINT ["/docker_config/startup.sh"]
