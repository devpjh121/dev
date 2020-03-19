FROM ubuntu:18.04

RUN mkdir -p /home/projects

WORKDIR /home/projects

ENV PATH $PATH:/usr/local/go/bin
ENV CBSTORE_ROOT /home/projects/cb-dragonfly
ENV CBLOG_ROOT /home/projects/cb-dragonfly
ENV CBMON_ROOT /home/projects/cb-dragonfly
ENV SPIDER_URL http://localhost:1024

RUN apt-get update && yes | apt-get install git && apt-get install git-core && apt-get install wget

RUN git clone https://github.com/cloud-barista/cb-dragonfly.git && cd cb-dragonfly/ &&\
 wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz &&\
 tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz &&\
 rm go1.13.4.linux-amd64.tar.gz

RUN cd cb-dragonfly/ && go mod download && go mod verify

EXPOSE 8094/udp 9090
