# Lab Two - Psuedo Distributed Hadoop


The goal is to set up a pseudo-distributed network and a single-machine distributed network using [Docker networking](https://docs.docker.com/network/network-tutorial-standalone/ "Docker networking").

In pseudo-distributed operations, each Hadoop daemon runs in a separate Java process. In a classic distributed operations environment, Hadoop would be run in multiple servers. Since we are using Docker containers, we can leverage Docker Network to create a Hadoop cluster in a single machine.

## Launch base Hadoop Docker image
```
# Pull the image you created in Lab One
$ docker pull {your repo}/modern_data_lab:lab-one

# Run your image in interactive mode
$ docker run -i -t  {your repo}/modern_data_lab:lab-one

# Verify this is the Hadoop image and it works
$ /usr/hadoop/bin/hadoop version
```

As a Hadoop Administrator, you will become very familiar with these four configuration files:
* core-default.xml
* hdfs-default.xml
* mapred-default.xml
* yarn-default.xml

Environmental variables can also be found in `/usr/hadoop/etc/hadoop/hadoop-env.sh`. Hadoop just a pretty good job of inferring locations assuming you performed a standard install, but we will set them explicitly later.

First, we will set up a pseudo-distributed network.
```
# Change to the configuration directory
$ cd /usr/hadoop/etc/hadoop

# Add a default filesystem property to core-site.xml:
  <configuration>
      <property>
          <name>fs.defaultFS</name>
          <value>hdfs://localhost:9000</value>
      </property>
  </configuration>

# Add a replication factor of 1 to hdfs-site.xml:
  <configuration>
      <property>
          <name>dfs.replication</name>
          <value>1</value>
      </property>
  </configuration>
```

The next step is to configure networking on the system.

ssh localhost

bash: ssh: command not found
```
# Install ssh on the server
$ yum -y install openssh-server openssh-clients

# Configure ssh to use a passphrase
$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
$ chmod 0600 ~/.ssh/authorized_keys
```

```
$ ssh localhost
ssh: connect to host localhost port 22: Cannot assign requested address
```

systemctl enable sshd.service

At this point, we have a container that has ssl enabled, but we have not exposed the default port (22). The easiest way to expose the port is to commit these changes, exit, and restart with the ports exposed on the command line.

```
$ docker ps -l

CONTAINER ID        IMAGE                            COMMAND             CREATED             STATUS              PORTS               NAMES
975665bb5fbb        2cdata/modern_data_lab:lab-one   "bash"              About an hour ago   Up About an hour                        wonderful_babbage
~ $

$ docker commit 975665bb5fbb 2cdata/modern_data_lab:lab-two

```

Still doesn't work because port 22 is not exposed in docker. Save and exit

exit docker image and run
docker run -i -p 22 -t 2cdata/modern_data_lab:lab-two

try this
https://blog.newnius.com/how-to-quickly-setup-a-hadoop-cluster-in-docker.html


https://stackoverflow.com/questions/19897743/exposing-a-port-on-a-live-docker-container
sudo docker ps
sudo docker commit <containerid> <foo/live>
sudo docker run -i -p 22 -p 8000:80 -m /data:/data -t <foo/live> /bin/bash

docker run -i -p 22 -p 8000:80 -m /data:/data -t <foo/live> /bin/bash



Now that we have a working single node Hadoop environment, we should push this image to Docker Hub using the lab-specific tag.

From the modern_data_lab Build Settings page, add a new row:
1. Type : Branch
2. Name : master
3. Dockerfile location: /hadoop/lab02
4. Docker tag name: lab-two


---
now lets try and run it with this centos 6.6 build
docker pull 2cdata/modern_data_lab:lab-two
git clone https://github.com/2cData/modern_data_lab.git
docker network create --driver=bridge hadoop
cd modern_data_lab/hadoop/lab02

this didn't work so I had to do this
chmod a+x start-container.sh
TODO how did he do it?
