# Create a minimal Centos 7 installation with Java 8
# to form the basis for building Hadoop clusters, Cassandra rings, etc
#
# The Dockerfiles build on one another from one lab to the next,
# so the different labs will be identified by tags

FROM centos:6 AS prerequisite

MAINTAINER 2CData <david.callaghan@2c-data.com>

RUN yum install wget -y && \
    cd ~ && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm" && \
    yum localinstall -y jdk-8u181-linux-x64.rpm && \
    rm ~/jdk-8u181-linux-x64.rpm && \
    echo "export JAVA_HOME=/usr/java/default/" > /etc/profile.d/java_home.sh && \
    yum clean all

# Set environment variables.
ENV HOME /root
ENV JAVA_HOME /usr/java/default/

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
