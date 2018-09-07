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

To integrate GitHub with Docker Hub to create a CI/CD pipeline for deploying Dockerfiles, you will need to configure the Docker Service. From GitHub,
1. Settings
2. Integrations & Services
3. Services
4. select Docker from the Services drop-down menu.

Optionally, if you are going to take advantage of the cloud-based elements of the training, you should install [Google Cloud Build](https://github.com/marketplace/google-cloud-build "Google Cloud Build"). This will be configured to build Docker images on Google Cloud Platform when Dockerfiles are committed to the master branch. This is optional, but serves to show the importance of Continuous Integration/Continuous Deployment (CI/CD) to the modern enterprise.

#### Git
I recommend going through the [Git from the CLI training](https://services.github.com/on-demand/github-cli/ "Git CLI") to understand how to work with git and github from the command line.

 - [install git locally](https://help.github.com/articles/set-up-git/ "Install Git locally")
 - [clone your repo](https://services.github.com/on-demand/github-cli/clone-repo-cli "Clone your repo")

### Cloud Services
You will need a credit or debit card to setup a cloud account. We will only use the free tier for this class. If you do not have a credit or debit card, don't worry. We will still be creating local clusters.

In this class, we will evaluate multi-cloud deployments from Day One. While most companies recognize the potential value in moving to the cloud, there are still concerns around putting a company's entire technology portfolio into a single provider. So while there is an additional administrative overhead in managing multiple cloud providers, a sensible separation of concerns can make for a stronger business case. We will use Google Cloud Platform to deploy our Hadoop cluster using Docker in Kubernetes and send processed data to Amazon Web Services to provide data to Lambda.   

#### Amazon Web Services
Amazon Web Services will host
- [create an AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/ "Create AWS account")
- [create an S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/create-bucket.html "Create an S3 bucket")

#### Google Cloud Platform
- [create a Google Cloud Platform account](https://cloud.google.com/billing/docs/how-to/manage-billing-account "Create GCP account")
- [link Github to Google cloud Build](https://github.com/marketplace/google-cloud-build "Link GitHub to GCP")

### Container Management
#### Docker
The preferred method for doing new things that may not work out well is to do it in a disposable container. This has two great advantages: you can't trash your machine and you can send the image to someone else once it works and it will definitely work on their machine.

 - [setup Docker locally](https://docs.docker.com/get-started/ "Get Started with Docker")
 - [create Docker Hub account](https://docs.docker.com/docker-id/ "Create Docker ID")

 Linking Docker to GitHub enables builds to be created in Docker Hub whenever a Dockerfile is updated in master.
 - [link Docker Hub to Git Hub](https://docs.docker.com/docker-hub/github/#creating-an-automated-build "Link Docker Hub to Git Hub")

### Pulling it all together

We will create a Centos image with Java 8 to form a base for all of our future modern data work. For the most part, you will be deploying to Red Hat Enterprise Linux in Production. Using Centos in Dev and Stage is a low cost way to make sure that your environments are consistent across the development lifecycle. This is Factor 10 in a [12 Factor App](https://12factor.net/ "12 Factor App"). At the time of this writing Java 9 was out but Java 8 was the minimum version required for most modern data platforms and likely all you will get at most enterprises.

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

While building a linux container running java is helpful, it does somewhat lack sustained dramatic impact. We will be manually executing commands, pulling them together into a Dockerfile and building a docker image with a tag related to the Lab.

From Docker Hub menu:
1. Click the Create drop-down
2. Select Create Automated Build
3. Click on the Create Auto-Build Github image (which is there because we linked the accounts earlier)
4. Select the modern_data_lab repository
5. Click the "Click here to customize behavior"
6. For now, just change the Docker tag from "latest" to "prerequisite". Each lab will add a different entry to this list.
7. Click the Create button

Whenever you commit a Dockerfile at the root directory level to the master branch, a new build tagged "prerequisite" will be added to the modern_data_lab image on your Docker Hub.

Delete the container.
```
# Copy the image id and paste into the command below
$ docker rm CONTAINER a8ee4590fefa

```
Pull the container that you pushed.
```
$ docker pull 2cdata/modern_data_lab:prerequisite
$ docker run -i -t  2cdata/modern_data_lab:prerequisite
# Note: replace 2cdata with your Docker Hub repo name.
```

You are now running your own container.

-----
### Deploy Docker images to Kubrnetes in Google Cloud Platform
Since we have already added the Google Cloud Build app to GitHub, any build that contains a Dockerfile and has been configured to deploy to Google will do so automatically.

From the Kubernetes Engine menu
1. Create Cluster
2. Deploy the Container
  - remember to create t1-micro instances
3. Click Deploy
4. Select your Docker image
5. Change the application name to hadoop-1
6. Deploy to the cluster you just created
7. Expose
