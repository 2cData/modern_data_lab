FROM modern_data_lab:prerequisite AS lab_one

MAINTAINER 2CData <david.callaghan@2c-data.com>

# Create a destination, download, uncompress and cleanup Hadoop
RUN mkdir /usr/hadoop && \
cd /usr/hadoop && \
wget http://www-us.apache.org/dist/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz && \
tar zxvf hadoop-3.1.1.tar.gz && \
rm hadoop-3.1.1.tar.gz && \
ln -s /usr/hadoop-3.1.1 /usr/hadoop

# Set environment variables.
ENV HADOOP_HOME /usr/hadoop
