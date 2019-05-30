#!/usr/bin/env bash
tag=latest
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$USER -t prax:$tag .