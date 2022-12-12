FROM ubuntu
MAINTAINER Sheikh Billah Alif "ambam3110@gmail.com"

EXPOSE 4000
EXPOSE 8130

ADD https://github.com/Rudolf-Barbu/Ward/archive/master.tar.gz /Ward.tar.gz
ADD ./profile /.profile
ADD ./setup.sh /setup.sh

# This section is only necessary if not using setup.sh
RUN tar xvzf Ward.tar.gz
RUN mv Ward-master/ Ward
RUN wget https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
RUN tar -xvf openjdk-13.0.1_linux-x64_bin.tar.gz
RUN mv jdk-13.0.1 /opt/
RUN wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar -xvf apache-maven-3.6.3-bin.tar.gz
RUN mv apache-maven-3.6.3 /opt/
RUN source /.profile

RUN ./setup.sh

WORKDIR /Ward
RUN . /.profile && mvn clean package

WORKDIR /Ward/target
ENTRYPOINT ["/bin/bash", "-c", ". /.profile && java -jar ward-1.8.8.jar"]
