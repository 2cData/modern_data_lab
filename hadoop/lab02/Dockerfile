# Create a Hadoop cluster

FROM 2cdata/modern_data_lab:lab-one AS lab-two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install ssh without key
#RUN yum -y install openssh-server openssh-clients && \
#    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
#    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN yum -y install openssh-server openssh-clients sudo rsync && \
    yum update -y libselinux && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# copy configuration files files
COPY config/* /tmp/

# manage ssh configuration files
RUN cp /tmp/ssh_config ~/.ssh/config && \
    chmod 600 ~/.ssh/config && \
    chown root:root ~/.ssh/config

# manage hadoop configuration files
RUN cp /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    cp /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    cp /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    cp /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    cp /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves

# manage executable scripts
RUN cp /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    chmod +x $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    cp /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    chmod +x ~/start-hadoop.sh && \
    cp /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# set up hadoop directories
RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# format namenode
RUN /usr/hadoop/bin/hdfs namenode -format

# run init scripts
RUN service sshd start && \
    $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    $HADOOP_PREFIX/sbin/start-dfs.sh && \

# set up scripts
RUN $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
RUN mkdir $HADOOP_PREFIX/input
RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input
RUN $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input
