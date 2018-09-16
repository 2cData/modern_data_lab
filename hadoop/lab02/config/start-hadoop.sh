#!/bin/bash

service sshd start
echo -e "\n"

$HADOOP_HOME/sbin/start-dfs.sh
echo -e "\n"

$HADOOP_HOME/sbin/start-yarn.sh
echo -e "\n"
