# Create a HAdoop cluster

FROM 2cdata/modern_data_lab:lab-one AS lab-two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install ssh without key
RUN yum -y install openssh-server openssh-clients && \
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# 91mFailed to get D-Bus connection: Operation not permitted
RUN systemctl enable sshd
RUN systemctl start sshd.service

# https://hub.docker.com/r/jdeathe/centos-ssh/~/dockerfile/

EXPOSE 22

# modify hadoop files
COPY config/* /tmp/

# manage configuration files
RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
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
RUN /usr/local/hadoop/bin/hdfs namenode -format

# TODO do I need this
# sbin/start-dfs.sh
