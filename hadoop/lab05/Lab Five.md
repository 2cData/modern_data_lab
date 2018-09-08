# Lab Five - Minimum Viable Hadoop
The goal is to set up an create a basic distributed cluster (one name node and three data nodes) on AWS.

## Create an Ubuntu AMI on the free tier
From EC2, select
1. Launch Instance ->
2. Ubuntu Server ->
3. t2.micro ->
4. 8GB EBS ->
5. uncheck Delete on Termination ->
6. Add tag (name = Hadoop) ->
7. New Security Group named HadoopSecurityGroup
8. (lock down IP range) ->
9. click Review and Launch ->
10. select “create a new key pair” ->
11. call it hadoopcluster ->
12. download ->
13. click Launch

## Create a Hadoop template node
On the AWS console, retrieve the DNS name.
1. Login to the EC2 node from the client.
2. On the client, prepare to ssh in
```
$ chmod 600 path/to/your/key.pem (first time only)
$ ssh -i path/to/your/key.pem ubuntu@your_dns_name
```
### Build a Hadoop instance
Follow the instructions from Lab One for building Minimum Viable Hadoop

TODO should I do this in MVP?
Add a user
```
sudo chown -R hadoop /usr/local/hadoop/
Update global variables
TODO these paths are not valid but should go into MVP
nano ~/.profile
Append
# Hadoop configuration
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH="PATH:JAVA_HOME/bin"
export HADOOP_HOME=/usr/local/hadoop
export PATH=PATH:HADOOP_HOME/bin
	Save, exit and apply
	. .profile
```

4. This step will be similar to the lab on creating a pseudo-distributed cluster, but this will be an actual functioning distributed cluster.

Edit Hadoop-env.sh
Edit core-site.xml
Edit hdfs-site.xml
Edit mapred-site.xml
Edit yarn-site.xml
