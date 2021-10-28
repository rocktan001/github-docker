######################################################################################################
##
# openharmony-docker-standard:0.0.5 
# 参考 https://gitee.com/openharmony/docs/blob/master/zh-cn/device-dev/quick-start/quickstart-standard-docker-environment.md
# git clone https://gitee.com/openharmony/docs.git
# cd docs/docker/
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

RUN apt-get -y install curl apt-utils  net-tools iputils-ping  git-lfs  python3-pip

#安装repo
RUN curl -s https://gitee.com/oschina/repo/raw/fork_flow/repo-py3 > /usr/local/bin/repo \
	&& chmod a+x /usr/local/bin/repo && pip3 install -i https://repo.huaweicloud.com/repository/pypi/simple requests

#拷贝ssh 鉴权文件
ADD etc/.ssh/id_rsa /root/.ssh/id_rsa
ADD etc/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 644 /root/.ssh/id_rsa.pub
RUN chmod 400 /root/.ssh/id_rsa
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
