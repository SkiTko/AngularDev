FROM ubuntu:18.04

ENV TZ JST-9

RUN apt-get update && \
    apt-get install -y \
        git \
        jq \
        unzip \
        wget \
        curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g \
        @angular/cli \
        @aws-amplify/cli \
        typescript

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN mkdir -p /home/docker/src /home/docker/.aws /home/docker/.ssh
COPY .aws/*  /home/docker/.aws/
COPY .ssh/*  /home/docker/.ssh/
COPY .gitconfig  /home/docker/.gitconfig

ARG UID=1000
RUN useradd -m -u ${UID} docker -d /home/docker
RUN chown -R docker:docker /home/docker
RUN chmod 700 /home/docker/.ssh
USER ${UID}

CMD ["/bin/bash"]
