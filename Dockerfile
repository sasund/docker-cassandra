FROM ubuntu

RUN apt-get update && apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common curl

# Install Java.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Cassandra
RUN DEBIAN_FRONTEND=noninteractive echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
RUN DEBIAN_FRONTEND=noninteractive curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dsc20=2.0.16-1 cassandra=2.0.16 opscenter datastax-agent

ENV CASSANDRA_CONFIG /etc/cassandra


# Run base config script
ADD scripts/config-cassandra-base.sh /usr/local/bin/config-cassandra-base
ADD scripts/cassandra-singlenode.sh /usr/local/bin/cassandra-singlenode
RUN /usr/local/bin/config-cassandra-base

RUN rm -f /etc/security/limits.d/cassandra.conf

EXPOSE 7199 7000 7001 9160 9042 22 8012 61621 8888

# Start Cassandra
ENTRYPOINT ["cassandra-singlenode"]