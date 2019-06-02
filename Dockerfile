FROM ubuntu:18.04
LABEL maintainer="Jimmy Au<jjbubudi@gmail.com>"

RUN apt-get update && \
    apt-get install -y gnupg && \
    echo "deb http://ppa.launchpad.net/gluster/glusterfs-6/ubuntu bionic main" > /etc/apt/sources.list.d/glusterfs-6.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F7C73FCC930AC9F83B387A5613E01B7B3FE869A9 && \
    apt-get update && \
    apt-get install -y glusterfs-server=6.1-ubuntu1~bionic1 && \
    apt-get install -y supervisor=3.3.1-1.1 && \
    apt-get install -y openssh-server=1:7.6p1-4ubuntu0.3 && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /run/sshd

COPY run.sh /run.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 2222 111 139 445 965 2049 24007 24008 38465 38466 38468 38469 49152-49251

CMD [ "/run.sh" ]