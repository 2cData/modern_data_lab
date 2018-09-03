# Modern Data Lab
#### Create a modern data infrastructure.

The goal of this series of labs is to provide practical, hands-on experience with the modern data ecosystem to prepare you to work effectively in an enterprise team. Working effectively in a team involves more than just knowing the essentials of Hadoop or Cassandra, although those skills are mandatory. You will also need to be familiar with working in a modern enterprise development environment.

## Prerequisites
### Source Control
We will be using git for source control and the GitHub Flow process in this tutorial.

#### GitHub
I recommend going through the [GitHub On-Demand training](https://services.github.com/on-demand/intro-to-github/ "GitHub 101") for a thorough grounding in GitHub.

You will need to perform the following:
 - [create a github account](https://guides.github.com/activities/hello-world/ "Create a github account")
 - [navigate to the course repo](https://github.com/2cData/modern_data_lab "Course repo")
 - [fork the course repo to your repo ](https://guides.github.com/activities/forking/ "Fork a repo")

#### Git
I recommend going through the [Git from the CLI training](https://services.github.com/on-demand/github-cli/ "Git CLI") to understand how to work with git and github from the command line.

 - [install git locally](https://help.github.com/articles/set-up-git/ "Install Git locally")
 - [clone your repo](https://services.github.com/on-demand/github-cli/clone-repo-cli "Clone your repo")

### Cloud Services
#### Amazon Web Services
You will need a credit or debit card to setup an AWS account. We will only use the free tier for this class. If you do not have a credit or debit card, don't worry. We will still be creating local clusters.

- [create an AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/ "Create AWS account")
- [launch and destroy a virtual machine](https://aws.amazon.com/getting-started/tutorials/launch-a-virtual-machine/?trk=gs_card "Create a machine instance")

### Container Management
#### Docker
The preferred method for doing new things that may not work out well is to do it a container. This has two great advantages: you can't trash your machine and you can send the image to someone else once it works and it will definitely work on their machine.

 - [setup Docker locally](https://docs.docker.com/get-started/ "Get Started with Docker")
 - [create Docker Hub account](https://docs.docker.com/docker-id/ "Create Docker ID")

tl;dr
```
# Pull my image from my repo at 2cdata
$ docker pull 2cdata/minimal_modern_data
```

We will create a Centos image with Java 8 to form a base for all of our future modern data work. For the most part, you will be deploying to Red Hat Enterprise Linux in Production. Using Centos in Dev and Stage is a low cost way to make sure that your environments are consistent across the development lifecycle. This is Factor X in a [12 Factor App](https://12factor.net/ "12 Factor App"). At the time of this writing Java 9 was out but Java 8 was the minimum required for most modern data platforms and likely all you will get at most enterprises.

From a terminal, run
```
# Get a base Centos image
$ docker pull centos

# Run in interactive mode
$ docker run -i -t centos

# update the OS
$ yum update -y

# Install wget to easily download files
$ yum install -y wget

# Download, install and verify Oracle's Java
$ wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
$ yum localinstall -y jdk-8u181-linux-x64.rpm
$ java -version

# Add JAVA_HOME as an environmental variable
$ echo "export JAVA_HOME=/usr/java/default/" > /etc/profile.d/java_home.sh
$ echo $JAVA_HOME

# Clean up
$ rm ~/jdk-8u181-linux-x64.rpm
```
You (should) now have a running container that have Centos running `java version "1.8.0_131"` with a JAVA_HOME environment variable pointed to `/usr/java/default`.

While building a linux container running java is helpful, it does somewhat lack sustained dramatic impact. Open a different tab and enter `docker ps -l` to get the container id of this running instance. We're going to save this image as minimal_modern_data. For example:
```
# List docker containers
$ docker ps -l

# Copy the CONTAINER ID to paste into the commit. For example:
$ docker commit a8ee4590fefa 2cdata/minimal_modern_data

# Note: replace 2cdata with your Docker Hub repo name.
```

I said there were two advantages to Docker: not breaking your machine and avoiding "works on my machine". I consider Docker as fundamental to development in this space as Git and Docker Hub plays the same role as GitHub for a team. Assuming you have set up and logged into Docker Hub, it's just another push.  
```
$ docker push 2cdata/minimal_modern_data
# Note: replace 2cdata with your Docker Hub repo name.
```

Delete the container.
```
# Copy the image id and paste into the command below
$ docker rm CONTAINER a8ee4590fefa

```
Pull the container that you pushed.
```
$ docker pull 2cdata/minimal_modern_data
# Note: replace 2cdata with your Docker Hub repo name.
```

```
$ docker run -i -t 2cdata/minimal_modern_data
# Note: replace 2cdata with your Docker Hub repo name.
```

You are now running your own container.

-----
Connect Docker Hub to GitHub



Connect GitHub to Google Cloud to deploy Docker in Kubernetes
In github, when I went to merge a PR that had a Dockerfile, it offered to pick an app that can manage automated builds
I set it up only for select repositories and just picked the modern_data_lab
chose my google account (personal)
Clicked the green Authorize button
It took me to GCP
 - create a new project (modern-data-lab) (underscores not allowed)
 - 120 free build minutes per day

It retrned me to Github with the confirmation
I navigated to GCP dashboard https://console.cloud.google.com/
Navigate to Compute Engine (this can take a minute or more)
I couldn't really figure out what it did
