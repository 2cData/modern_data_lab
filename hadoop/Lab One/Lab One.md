# Lab One - Minimum Viable Hadoop
The goal is to set up a single node Hadoop cluster on your local machine and run a MapReduce application manually.

## Launch base Docker image
```
# Pull the base image you created in the README and run interactively
$ docker pull 2cdata/minimal_modern_data
$ docker run -i -t 2cdata/minimal_modern_data
```

## Download Hadoop
We will be following, with some modification, Apche's instructure for setting up a [single-node Hadoop cluster](https://hadoop.apache.org/docs/r3.1.1/hadoop-project-dist/hadoop-common/SingleCluster.html).
```
# Create a destination for Hadoop
$ cd /usr

# Download Hadoop
$ wget http://www-us.apache.org/dist/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz

# Uncompress Hadoop tarball
$ tar zxvf hadoop-3.1.1.tar.gz
$ rm hadoop-3.1.1.tar.gz

# Create a symbolic link to the uncompressed directory to make upgrades easier on scripts
$ ln -s /usr/hadoop-3.1.1 /usr/hadoop

# Check to see if Hadoop is installed and functioning
$ cd /usr/hadoop
$ bin/hadoop version
# You should see Hadoop 3.1.1!
```

We have verified that you have a working single node Hadoop installation by checking the installed version. But it would definitely be more satisfying to do a Hello, World exercise.
```

# Copy all the Hadoop configuration files to an input directory
$ mkdir ~/input
$ cp /usr/hadoop/etc/hadoop/*.xml ~/input

# Run a mapreduce job to count all instances of a string beginning with 'dfs' and send the results to a new directory called `output`
$  /usr/hadoop/bin/hadoop jar /usr/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.1.jar grep ~/input ~/output 'dfs[a-z.]+'

# Check the results of the mapreduce operation
$ cat ~/output/*
# Should return `1	dfsadmin`

# Remove the output directory since it will throw an error if you try to rerun in.
$ rm -rf ~/output
```

Scroll up to the top of the output and read from the beginning. You can learn a lot about the map reduce process by reading the stack trace. And you can learn even more by reading the [source code directly](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/Grep.java).

You are not expected to understand what you are seeing just yet. More detailed explanations come later; but it's helpful to have early exposure. It's just Java.

Now that we have a working single node Hadoop environment, we should push this image to Docker Hub.

```
# In a new tab, find the container id of yur running Docker container
$ docker ps -l

# Commit this container as minimun_viable_hadoop
$ docker commit 10536ef35c92 2cdata/minimum_viable_hadoop
# Remember to change 2cdata to your Docker Hub account

# Push the new image to your Docker hub
$ docker push 2cdata/minimum_viable_hadoop
# Remember to change 2cdata to your Docker Hub account

```
