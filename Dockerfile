ARG BASE_IMAGE=arm32v7/ubuntu:18.04

FROM ${BASE_IMAGE}
LABEL maintainer="Jimmy Au<jjbubudi@gmail.com>"

ENV container=docker \
    LC_ALL=C \
    DEBIAN_FRONTEND=noninteractive

COPY qemu-arm-static /usr/bin

RUN apt-get update && \
    apt-get install -y gnupg && \
    printf "\ndeb http://ppa.launchpad.net/gluster/glusterfs-6/ubuntu bionic main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F7C73FCC930AC9F83B387A5613E01B7B3FE869A9 && \
    apt-get update && \
    apt-get install -y glusterfs-server && \
    apt-get install -y supervisor && \
    apt-get install -y openssh-server && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sed -i '/Port 22/c\Port 2222' /etc/ssh/sshd_config && \
    mkdir -p /run/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 2222 111 139 445 965 2049 24007 24008 38465 38466 38468 38469 49152-49251

CMD [ "/usr/bin/supervisord" ]