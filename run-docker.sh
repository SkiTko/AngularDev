#! /bin/bash

cp -r $HOME/.aws .
mkdir src
docker build -t angular-dev .
docker run -it --rm \
    -v $(pwd)/src:/home/docker/src \
    -p 4200:4200 -p 9876:9876 \
    angular-dev
