FROM       ubuntu:12.04
MAINTAINER Kushal M K

RUN apt-get update

RUN apt-get install -y openssh-server
RUN apt-get install xorg -y
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
EXPOSE 2222

CMD    ["/usr/sbin/sshd", "-D"]
