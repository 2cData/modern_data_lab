FROM modern_data_lab:lab_one AS lab_two

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Install SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
chmod 0600 ~/.ssh/authorized_keys



# modify hadoop files
cd ~/hadoop-3.1.1/etc/hadoop
chmod 755 core-site.xml
sed -i '$d' core-site.xml
sed -i -e '$a\
  <property>\
      <name>fs.defaultFS</name>\
      <value>hdfs://localhost:9000</value>\
  </property>\
</configuration>' core-site.xml
