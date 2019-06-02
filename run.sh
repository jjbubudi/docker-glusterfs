#!/bin/bash
set -e

SSH_PORT=${SSH_PORT-"2222"}
SSH_PASSWORD=${SSH_PASSWORD-""}

configure_ssh() {
    sed -i "/Port 22/c\Port ${SSH_PORT}" /etc/ssh/sshd_config
    sed -i "/#PasswordAuthentication .*/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    sed -i "/#PermitRootLogin .*/c\PermitRootLogin yes" /etc/ssh/sshd_config
}

change_password() {
    if [ ! -z "${SSH_PASSWORD}" ]; then
        echo "root:${SSH_PASSWORD}" | chpasswd
    else
        echo "SSH password must not be empty"
        exit 1
    fi
}

configure_ssh
change_password

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf