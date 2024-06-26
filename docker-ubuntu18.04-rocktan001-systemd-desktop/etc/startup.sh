#! /bin/bash

ROOT_PWD=${ROOT_PWD:-"F96AEB124C"}
ROCK_USER_PWD=${ROCK_USER_PWD:-"F96AEB124C"}


## initialize environment
if [ ! -f "/init_flag" ]; then

	if [ -n "$ROOT_PWD" ]; then
		echo "[i] Reset  Root Password: $ROOT_PWD"
		echo "root:${ROOT_PWD}" | chpasswd

	fi

	if [ -n "$ROCK_USER_PWD" ]; then
		echo "[i] Reset  rock Password: $ROCK_USER_PWD"
		echo "rock:${ROCK_USER_PWD}" | chpasswd

	fi
	if [ -n "$SSH_PORT" ]; then
		echo "[i] Change SSH listen Port: $SSH_PORT"
		sed -i -e "s/Port 60023/Port ${SSH_PORT}/g" /etc/ssh/sshd_config

	fi

	if [ -n "$YSEMI_USER" ]; then
		useradd -m -s /bin/bash $YSEMI_USER
		echo "$YSEMI_USER:$YSEMI_USER" | chpasswd

		echo "create $YSEMI_USER user ok?"

	fi
    # update init flag
    echo  "ok" > /init_flag

fi



echo "[i] Setting end,have fun."

exec "$@"