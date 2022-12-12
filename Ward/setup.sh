#!/bin/bash

# Updating installer repositories
apt update -y && apt upgrade -y
apt install wget -y

# NEED to uncomment this portion if not using Dockerfile
# Installing the required dependencies
# apt install git -y
# Cloning the Ward repository
# git clone
# Installing Java
# source /.profile
# Running the application
# java -jar /Ward/target/ward-1.8.8.jar

# Managing the Ward github repo
tar xvzf Ward.tar.gz
mv Ward-master/ Ward

# Installing Java
wget https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
tar -xvf openjdk-13.0.1_linux-x64_bin.tar.gz
mv jdk-13.0.1 /opt/

# Installing Maven
wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar -xvf apache-maven-3.6.3-bin.tar.gz
mv apache-maven-3.6.3 /opt/
