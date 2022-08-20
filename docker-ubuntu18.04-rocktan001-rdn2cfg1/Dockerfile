FROM docker.io/ubuntu:18.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list
ADD etc/fd-musl_8.2.1_amd64.deb /root/fd-musl_8.2.1_amd64.deb

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

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

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
gdisk


RUN pip install cmake --upgrade -i "https://pypi.doubanio.com/simple/"

#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#安装supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD etc/supervisord.conf /etc/supervisord.conf

RUN apt-get -y install curl apt-utils  net-tools iputils-ping

RUN apt install tsocks -y
RUN apt-get -y install gcc-aarch64-linux-gnu qemu-system-aarch64
RUN apt-get -y install python3-pyelftools
#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

COPY etc/sshd_config /etc/ssh/sshd_config
COPY etc/tsocks.conf /etc/tsocks.conf

RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
RUN dpkg -i /root/fd-musl_8.2.1_amd64.deb
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
