#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

VERSION=$(<VERSION)
# FROM=$(<FROM)
# SPECIFIC_FILE=Dockerfile.specific
IMAGE_NAME=synology-docker-homebridge-v$VERSION
# SED_COMMAND="sed -i \"/#####SPECIFIC#####/ r $SPECIFIC_FILE\" Dockerfile"

# source homebridge-common.sh

ACTION=$1

if [ -z "$ACTION" ];
  then
    echo "usage: $0 <build|run|stop|start|remove|rerun|attach|push|logs>";
    exit 1;
fi

_build() {
  # Generate Dockerfile
  ## echo $FROM > Dockerfile
  ## cat Dockerfile.common >> Dockerfile
  ## eval $SED_COMMAND

  # Build
  docker build --tag="psmith/synology-docker-homebridge:$VERSION" .
}

_run() {
  # Run (first time)
  docker run -d --net=host -p 51826:51826 -v /etc/homebridge:/root/.homebridge --name $IMAGE_NAME psmith/synology-docker-homebridge:$VERSION
}

_stop() {
  # Stop
  docker stop $IMAGE_NAME
}

_start() {
  # Start (after stopping)
  docker start $IMAGE_NAME
}

_remove() {
  # Remove
  docker rm $IMAGE_NAME
}

_rerun() {
  _stop
  _remove
  _run
}

_attach() {
  docker exec -ti $IMAGE_NAME bash
}

_logs() {
  docker logs $IMAGE_NAME
}

_push() {
  docker push psmith/synology-docker-homebridge:$VERSION
}

eval _$ACTION
