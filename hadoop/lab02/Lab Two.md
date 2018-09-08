# Lab Two - Psuedo Distributed Hadoop


The goal is to set up a pseudo-distributed network and a single-machine distributed network using [Docker networking](https://docs.docker.com/network/network-tutorial-standalone/ "Docker networking").

In pseudo-distributed operations, each Hadoop daemon runs in a separate Java process. In a classic distributed operations environment, Hadoop would be run in multiple servers. Since we are using Docker containers, we can leverage Docker Network to create a Hadoop cluster in a single machine.

## Launch base Hadoop Docker image
```
# Pull the image you created in Lab One
$ docker pull ???/minimum_viable_hadoop

# Run your image in interactive mode
$ docker run -i -t ???/minimum_viable_hadoop

# Verify this is the Hadoop image and it works
$ /usr/hadoop/bin/hadoop version
```

As a Hadoop Administrator, you will become very familiar with these four configuration files:
* core-default.xml
* hdfs-default.xml
* mapred-default.xml
* yarn-default.xml

Environmental variables can also be found in `/usr/hadoop/etc/hadoop/hadoop-env.sh`. Hadoop just a pretty good job of inferring locations assuming you performed a standard install, but we will set them explicitely later.

First, we will set up a pseudo-distributed network.
```
# Change to the configuration directory
$ cd /usr/hadoop/ec/hadoop

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
ssh was not found, so install
```
# Install ssh on the server
$ yum -y install openssh-server openssh-clients

# Configure ssh to use a passphrase
$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
$ chmod 0600 ~/.ssh/authorized_keys
```

At this point, we have a container that has ssl enabled, but we have not exposed the default port (22). The easiest way to expose the port is to commit these changes, exit, and restart with the ports exposed on the command line.

```
docker ps -l
docker commit {CONTAINERID} ???/pseudo-distributed_hadoop

```

Still doesn't work because port 22 is not exposed in docker. Save and exit

https://stackoverflow.com/questions/19897743/exposing-a-port-on-a-live-docker-container
sudo docker ps
sudo docker commit <containerid> <foo/live>
sudo docker run -i -p 22 -p 8000:80 -m /data:/data -t <foo/live> /bin/bash


OK. Go to https://labs.play-with-docker.com/
May need to rethink this with Dockerfiles


Now that we have a working single node Hadoop environment, we should push this image to Docker Hub using the lab-specific tag.

From the modern_data_lab Build Settings page, add a new row:
1. Type : Branch
2. Name : master
3. Dockerfile location: /hadoop/lab2
4. Docker tag name: lab-two
