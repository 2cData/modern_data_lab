## Step one - create docker image
The preferred method for doing new things that may not work out well is to do it a container. This has two great advantages: you can't trash your machine and you can send the image to someone else once it works and it will definitely work on their machine.

tl;dr
```
docker pull 2cdata/minimal_modern_data
```

We will create a Centos image with Java 8 to form a base for all of our future modern data work. For the most part, you will be deploying to Red Hat Enterprise Linux in Production. Using Centos in Dev and Stage is a low cost way to make sure that your environments are consistent across the development lifecycle. This is Factor X in a [12 Factor App](https://12factor.net/ "12 Factor App"). At the time of this writing Java 9 was out but Java 8 was the minimum required for most modern data platforms and likely all you will get at most enterprises.

From a terminal, run
```
docker pull centos
docker run -i -t centos
cd ~
yum install wget
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
yum localinstall jdk-8u181-linux-x64.rpm
echo "export JAVA_HOME=/usr/java/default/" > /etc/profile.d/java_home.sh
rm ~/jdk-8u181-linux-x64.rpm
java -version
echo $JAVA_HOME
```
You (should) now have a running container that have Centos running `java version "1.8.0_131"` with a JAVA_HOME environment variable pointed to `/usr/java/default`.

While building a linux container running java is helpful, it does somewhat lack sustained dramatic impact. Open a different tab and enter `docker ps -l` to get the container id of this running instance. We're going to save this image as minimal_modern_data. For example:
```
docker ps -l
```
Copy the CONTAINER ID to paste into the commit.
```
docker commit a8ee4590fefa 2cdata/minimal_modern_data
```

I said there were two advantages to Docker: not breaking your machine and avoiding "works on my machine". I consider Docker as fundamental to development in this space as Git and Docker Hub plays the same role as GitHub for a team. Assuming you have set up and logged into Docker Hub, it's just another push.  
```
docker push 2cdata/minimal_modern_data
```

If you go back to the top and look at the tl;dr command, you can be proud of yourself for working through this fundamental introduction to a core concept.
