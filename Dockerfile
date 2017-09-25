#
# Dockerfile for Debian
#
FROM debian:stretch
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install Sismics repository
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates software-properties-common curl gnupg
RUN curl -fsSL https://www.sismics.com/pgp | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://nexus.sismics.com/repository/apt-stretch/ stretch main"

# Configure settings
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN echo "Europe/Paris" > /etc/timezone
RUN dpkg-reconfigure tzdata
COPY etc /etc
RUN cat /etc/.bashrc_additional >> ~/.bashrc
RUN apt-get -y -q install vim less procps unzip wget && \
    rm -rf /var/lib/apt/lists/*
