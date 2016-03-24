#!/bin/bash
docker kill homebridge
docker rm homebridge
docker run --name=homebridge -d --restart=always --net=host -p 51826:51826 -v /volume1/docker/homebridge:/root/.homebridge psmith/synology-docker-homebridge:0.13
