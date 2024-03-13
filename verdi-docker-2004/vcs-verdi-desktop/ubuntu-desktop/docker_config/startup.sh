#!/bin/sh

if [ -n "$ROOT_PWD" ]; then
    echo "[i] Reset  Root Password: $ROOT_PWD"
    echo "root:${ROOT_PWD}" | chpasswd

fi

if [ -n "$SSH_PORT" ]; then
    echo "[i] Change SSH listen Port: $SSH_PORT"
    sed -i -e "s/#Port 22/Port ${SSH_PORT}/g" /etc/ssh/sshd_config

fi

if [ -n "$YSEMI_USER" ]; then
    useradd -m -s /bin/bash $YSEMI_USER
    echo "$YSEMI_USER:$YSEMI_USER" | chpasswd

    echo "create $YSEMI_USER user ok?"
else
    echo "no user set...."
    exit
fi
## initialize environment
if [ ! -f "/docker_config/init_flag" ]; then
    # create user
    useradd --create-home --no-log-init -u $UID -g $GID $USER
    usermod -aG sudo $USER
    echo "$YSEMI_USER:$YSEMI_USER" | chpasswd
    chsh -s /bin/bash $YSEMI_USER
    echo "create $YSEMI_USER user ok?"
    # copy xfce4 config
    mkdir /home/$YSEMI_USER/.config
    cp -r /docker_config/xfce4 /home/$YSEMI_USER/.config
    chown -R $UID:$GID /home/$YSEMI_USER/.config
    # vgl for user
    echo "export PATH=/usr/NX/scripts/vgl:\$PATH" >> /home/$YSEMI_USER/.bashrc
    cat /synopsys/license/bashrc.sh >> /home/$YSEMI_USER/.bashrc
    ln -s /synopsys/usr/synopsys/ /usr/synopsys
    # custom init
    bash /docker_config/init.sh


    # update init flag
    echo  "ok" > /docker_config/init_flag
fi

/usr/sbin/sshd
/etc/init.d/dbus start
/etc/NX/nxserver --startup
tail -f /usr/NX/var/log/nxserver.log
