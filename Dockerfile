##############################################################
## Stage 1 - Install Go & Set Go env
##############################################################

FROM ubuntu:18.04

RUN apt-get update && yes | apt-get install wget &&\
 wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz &&\
 tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz &&\
 rm go1.13.4.linux-amd64.tar.gz

ENV PATH $PATH:/usr/local/go/bin

##############################################################
## Stage 2 - Application Set up
##############################################################

# Clone project to docker
ADD . /project/cb-dragonfly

WORKDIR /project/cb-dragonfly

# Use bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh &&  go mod download && go mod verify

# Run /bin/bash -c "source /app/conf/setup.env"
ENV CBSTORE_ROOT /project/cb-dragonfly
ENV CBLOG_ROOT /project/cb-dragonfly
ENV CBMON_PATH /project/cb-dragonfly

RUN cd /project/cb-dragonfly/pkg/manager/main;go build -o runMyapp;cp runMyapp /project/cb-dragonfly

ENTRYPOINT ["./runMyapp"]

EXPOSE 8094/udp 9090

