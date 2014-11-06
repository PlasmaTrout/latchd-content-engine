FROM ubuntu:14.04
MAINTAINER Jeff Downing <jeff.downing@latchd.com>

# Getting Java 8 Setup and Ready
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer

# Download A Java8 Compatible Version Of Sling (Custom Build)
CMD mkdir -p /opt/apache-sling
# ADD https://github.com/PlasmaTrout/apache-sling-java8/raw/master/builds/org.apache.sling.launchpad-7-SNAPSHOT-standalone.jar /opt/apache-sling/
ADD http://mirror.metrocast.net/apache//sling/org.apache.sling.launchpad-7-standalone.jar /opt/apache-sling/
# Exposing only 8080 and 8000
EXPOSE 8080
EXPOSE 30303

# Run command
CMD cd /opt/apache-sling && java -Xmx384M -agentlib:jdwp=transport=dt_socket,address=30303,server=y,suspend=n -jar org.apache.sling.launchpad-7-standalone.jar
