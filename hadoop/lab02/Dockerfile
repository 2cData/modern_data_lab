# Create a HAdoop cluster

FROM 2cdata/modern_data_lab:lab-one AS lab-two

MAINTAINER 2CData <david.callaghan@2c-data.com>



# 91mFailed to get D-Bus connection: Operation not permitted
# this is how this is supposed to work
# https://github.com/docker-library/docs/tree/master/centos
# note the centos s very annoying in Docker for this reason
# Ubuntu is better at tgis time
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
VOLUME [ "/sys/fs/cgroup"

# Install ssh without key
RUN yum -y install openssh-server openssh-clients && \
    yum clean all && \
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN systemctl enable sshd.service
#RUN systemctl start sshd.service

# https://hub.docker.com/r/jdeathe/centos-ssh/~/dockerfile/
# if this doesn't work, I'm jus going to go down to centos 6.5
# https://hub.docker.com/r/sequenceiq/hadoop-docker/~/dockerfile/
EXPOSE 22

# modify hadoop files
COPY config/* /tmp/

# manage configuration files
RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves

# manage executable scripts
RUN mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    chmod +x ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# format namenode
RUN /usr/hadoop/bin/hdfs namenode -format

# TODO do I need this
# sbin/start-dfs.sh
CMD ["/usr/sbin/init"]
