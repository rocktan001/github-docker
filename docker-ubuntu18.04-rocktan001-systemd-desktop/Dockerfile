ARG BASE_IMAGE=nvidia/opengl:1.2-glvnd-devel-ubuntu18.04
From $BASE_IMAGE


RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install systemd
#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN apt-get -y install curl apt-utils  net-tools iputils-ping locales

## Install desktop
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-terminal xfce4-power-manager fonts-wqy-zenhei &&\
    locale-gen zh_CN.UTF-8

## Install nomachine
COPY etc/nomachine.deb /nomachine.deb
RUN  dpkg -i /nomachine.deb && rm /nomachine.deb

RUN apt-get install -y pulseaudio && mkdir -p /var/run/dbus


# Install Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&\
    apt-get install -yf ./google-chrome-stable_current_amd64.deb &&\
    rm google-chrome-stable_current_amd64.deb

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