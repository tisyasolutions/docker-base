FROM centos:centos7
LABEL image=tss-base
USER root

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

RUN yum update -y
RUN yum install -y curl which tar sudo openssh-server openssh-clients rsync java-1.8.0-openjdk-devel libsnappy-dev wget
RUN yum install -y centos-release-scl 
RUN yum install -y rh-python36 
RUN yum install -y epel-release 
RUN yum install -y python-pip


RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -A

WORKDIR /
EXPOSE 22

