# Create a Hadoop cluster

FROM 2cdata/modern_data_lab:lab-one AS lab-two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install ssh without key
RUN yum -y install openssh-server openssh-clients && \
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# modify hadoop files
COPY config/* /tmp/

# manage configuration files
RUN cp /tmp/ssh_config ~/.ssh/config && \
    cp /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    cp /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    cp /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    cp /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    cp /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    cp /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves

# manage executable scripts
RUN cp /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    cp /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# manage Hadoop 3.x environmental variable
ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER root
ENV YARN_NODEMANAGER_USER root


# format namenode
RUN /usr/hadoop/bin/hdfs namenode -format

#RUN service sshd start
#CMD [ "sh", "-c", "service sshd start; bash"]

#rpm --query centos-release
