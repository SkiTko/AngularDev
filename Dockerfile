FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y unzip \
        wget \
        curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @angular/cli @aws-amplify/cli && \
    mkdir -p /home/docker

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN mkdir /home/docker/src /home/docker/.aws
COPY .aws/*  /home/docker/.aws/
ENV TZ JST-9

ARG UID=1000
RUN useradd -m -u ${UID} docker -d /home/docker
RUN chown -R docker:docker /home/docker
USER ${UID}

CMD ["/bin/bash"]