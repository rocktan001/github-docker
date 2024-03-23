ARG BASE_IMAGE=nvidia/opengl:1.2-glvnd-devel-ubuntu20.04
From $BASE_IMAGE


RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install systemd
#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN apt-get -y install curl apt-utils  net-tools iputils-ping locales

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

## Install nomachine
COPY etc/nomachine.deb /nomachine.deb
RUN  dpkg -i /nomachine.deb && rm /nomachine.deb

RUN apt-get install -y pulseaudio && mkdir -p /var/run/dbus


#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:root" | chpasswd
RUN useradd -m -s /bin/bash rock
RUN echo "rock:rock" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

COPY etc/sshd_config /etc/ssh/sshd_config

RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]
ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/bin/systemd"]