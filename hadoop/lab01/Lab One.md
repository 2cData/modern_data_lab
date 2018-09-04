# Lab One - Minimum Viable Hadoop
The goal is to set up a single node Hadoop cluster on your local machine and run a MapReduce application manually.

You will need the name of your Docker Hub account you created in the Prerequisites.

## Launch base Docker image
```
# Pull the base image you created in the README and run interactively.
$ docker pull ???/minimal_modern_data
$ docker run -i -t ???/minimal_modern_data
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

Now that we have a working single node Hadoop environment, we should push this image to Docker Hub using the lab-specific tag.
```
# From /hadoop/lab1 directory
$ docker build -t 2cdata/modern_data_lab:lab-one .
$ docker push 2cdata/modern_data_lab:lab-one
```
