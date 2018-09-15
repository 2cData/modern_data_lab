FROM modern_data_lab:lab_one AS lab_two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
chmod 0600 ~/.ssh/authorized_keys



# modify hadoop files
# https://stackoverflow.com/questions/33439230/how-to-write-commands-with-multiple-lines-in-dockerfile-while-preserving-the-new
RUN cd ~/hadoop/etc/hadoop  && \
  chmod 755 core-site.xml  && \
  sed -i.bak '/configuration/d' core-site.xml && \
  sed -i -e '$a\
  <configuration>\
    <property>\
      <name>fs.defaultFS</name>\
      <value>hdfs://localhost:9000</value>\
    </property>\
  </configuration>' core-site.xml

  chmod 755 hdfs-site.xml  && \
  sed -i.bak '/configuration/d' hdfs-site.xml && \
  sed -i -e '$a\
  <configuration>\
    <property>\
        <name>dfs.replication</name>\
        <value>1</value>\
    </property>\
  </configuration>' hdfs-site.xml
