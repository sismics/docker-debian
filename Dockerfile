#
# Dockerfile for Debian
#
FROM debian:bookworm
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install Sismics repository & a few utils
RUN apt-get update && \
    apt-get install -y apt-transport-https wget curl gnupg vim less procps unzip && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://www.sismics.com/pgp | apt-key add -
RUN echo "deb [arch=amd64] https://nexus.sismics.com/repository/apt-stretch/ stretch main" >> /etc/apt/sources.list

# Configure settings
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN echo "Europe/Paris" > /etc/timezone
RUN dpkg-reconfigure tzdata
COPY etc /etc
RUN echo "for f in \`ls /etc/bashrc.d/*\`; do . \$f; done;" >> ~/.bashrc
