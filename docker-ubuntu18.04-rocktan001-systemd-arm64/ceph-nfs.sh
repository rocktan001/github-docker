#!/bin/bash

# set -x
function nfs_deploy()
{	
	sec=$(grep "key" ceph.client.admin.keyring  | awk -F  ' = ' '{print $2}')
	mount -t ceph 192.168.10.106:6789:/ /mnt/nfs-ysemi -o name=admin,secret=${sec}
	chmod 777 /mnt/nfs-ysemi/
}

nfs_deploy