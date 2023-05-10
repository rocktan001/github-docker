#!/bin/bash

SSH_PORT=10060
MON_HOST_NAME=systemd01
OSD_HOST_NAME1=systemd02
OSD_HOST_NAME2=systemd03
MON_HOST_IP=192.168.199.227
OSD_HOST_IP1=10.10.0.102 # 根据子网来设置
OSD_HOST_IP2=10.10.0.103 # 根据子网来设置

OSD_WORKSPACE=/media/disk1/YSEMI/ceph_osd # 用来保存OSD 虚拟硬盘

function create_ceph_osd()
{
	apt install xfsprogs
	pushd ${OSD_WORKSPACE}
	dd if=/dev/zero of=ceph1.xfs bs=1M count=2500
	dd if=/dev/zero of=ceph2.xfs bs=1M count=2500
	dd if=/dev/zero of=ceph3.xfs bs=1M count=2500
	mkfs.xfs ceph1.xfs
	mkfs.xfs ceph2.xfs
	mkfs.xfs ceph3.xfs

	if [ -d "/mnt/ceph1" ]; then
		rm -rf /mnt/ceph1
		rm -rf /mnt/ceph2
		rm -rf /mnt/ceph3
		umount /mnt/ceph1
		umount /mnt/ceph2
		umount /mnt/ceph3
	fi
		mkdir -p /mnt/{ceph1,ceph2,ceph3}
		mount ceph1.xfs /mnt/ceph1
		mount ceph2.xfs /mnt/ceph2
		mount ceph3.xfs /mnt/ceph3
		chown ceph:ceph /mnt/ceph1 && chown ceph:ceph /mnt/ceph2 && chown ceph:ceph /mnt/ceph3
	popd
}

function create_ceph_docker()
{
	docker rm -f ${MON_HOST_NAME} ${OSD_HOST_NAME1} ${OSD_HOST_NAME2}

	docker run -tid --name ${MON_HOST_NAME}  \
	--hostname=${MON_HOST_NAME}  --net host \
	--privileged --restart always  \
	-e SSH_PORT=${SSH_PORT} -e ROOT_PWD=root -e YSEMI_USER=Y{SSH_PORT} \
	--add-host=${MON_HOST_NAME}:${MON_HOST_IP} --add-host=${OSD_HOST_NAME1}:${OSD_HOST_IP1} --add-host=${OSD_HOST_NAME2}:${OSD_HOST_IP2} \
	-v /media/disk1:/media/disk1 -v /mnt/ceph1:/mnt/ceph1  \
	     --env container=docker \
	     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
	     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
	     --mount type=tmpfs,destination=/tmp \
	     --mount type=tmpfs,destination=/run \
	     --mount type=tmpfs,destination=/run/lock \
	rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0

	docker run -tid --name ${OSD_HOST_NAME1}   \
	--hostname=${OSD_HOST_NAME1}  --network=cluster-net --ip=${OSD_HOST_IP1} \
	--privileged --restart always  \
	-e SSH_PORT=22 -e ROOT_PWD=root -e YSEMI_USER=Y{SSH_PORT} \
	--add-host=${MON_HOST_NAME}:${MON_HOST_IP} --add-host=${OSD_HOST_NAME1}:${OSD_HOST_IP1} --add-host=${OSD_HOST_NAME2}:${OSD_HOST_IP2} \
    -v /mnt/ceph2:/mnt/ceph2  \
	     --env container=docker \
	     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
	     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
	     --mount type=tmpfs,destination=/tmp \
	     --mount type=tmpfs,destination=/run \
	     --mount type=tmpfs,destination=/run/lock \
	rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0

	docker run -tid --name ${OSD_HOST_NAME2}   \
	--hostname=${OSD_HOST_NAME2}  --network=cluster-net --ip=${OSD_HOST_IP2} \
	--privileged --restart always  \
	-e SSH_PORT=22 -e ROOT_PWD=root -e YSEMI_USER=Y{SSH_PORT} \
	--add-host=${MON_HOST_NAME}:${MON_HOST_IP} --add-host=${OSD_HOST_NAME1}:${OSD_HOST_IP1} --add-host=${OSD_HOST_NAME2}:${OSD_HOST_IP2} \
    -v /mnt/ceph3:/mnt/ceph3  \
	     --env container=docker \
	     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
	     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
	     --mount type=tmpfs,destination=/tmp \
	     --mount type=tmpfs,destination=/run \
	     --mount type=tmpfs,destination=/run/lock \
	rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0
}

function create_ceph_network()
{
	docker network rm cluster-net
	docker network create --subnet=10.10.0.0/24  cluster-net
}

# create_ceph_network
create_ceph_osd
create_ceph_docker