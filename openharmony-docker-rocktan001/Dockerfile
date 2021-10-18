######################################################################################################
##
# openharmony-docker:0.0.5 
# 参考 https://gitee.com/openharmony/docs/blob/master/zh-cn/device-dev/get-code/%E8%8E%B7%E5%8F%96%E5%B7%A5%E5%85%B7.md
# git clone https://gitee.com/openharmony/docs.git
# cd docs/docker
# /build.sh
##
######################################################################################################
FROM openharmony-docker:0.0.5
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list

RUN apt-get update

#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#安装supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD etc/supervisord.conf /etc/supervisord.conf

RUN apt-get -y install curl apt-utils  net-tools iputils-ping 

#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh


RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
