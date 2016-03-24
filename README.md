
# synology-docker-homebridge

Docker image of Homebrigde for running on a Synology NAS

For details see https://github.com/nfarina/homebridge

This is a Docker built version of Homebridge designed to run on a Synology NAS from https://github.com/nfarina/homebridge and built from https://github.com/cbrandlehner/homebridge-docker version. I am running a Synology 1815+ and DSM 6.0-7321.

The Docker image has already been built and is on the Docker Hub repository at https://hub.docker.com/r/psmith/synology-docker-homebridge/ 

On your Synology NAS, create a "docker" folder on your shared volume and then create a subfolder "homebridge". After creating your config.json and package.json files, copy them to the shared "docker/homebridge" folder. The config.json will have your homebridge config and the package.json will list the NPM packages that you want to be built each time the container is run. See https://github.com/psmith3/synology-docker-homebridge/tree/master/config-sample for samples of both the config.json and package.json files.

Run the container from command line by in the NAS entering
sudo docker run --name=homebridge -d --restart=always --net=host -p 51826:51826 -v /volume1/docker/homebridge:/root/.homebridge psmith/synology-docker-homebridge:0.13
Enter your root password to run the command.

If you are running the firewall on the Synology, you will need to open TCP 5353 & 51826. If you do not, the firewall will close within a few minutes and your app will not be reachable from an IOS device.

If you want to build your own Docker image follow these steps:
## Configuration

Copy `config-sample.json` to `config.json` and adapt to your likings.

## Build

`./homebridge.sh build`

## Run

### run first time

`./homebridge.sh run`

### stop

`./homebridge.sh stop`

### start

(after stopping)

`./homebridge.sh start`

### remove

(needed before run is possible again)

`./homebridge.sh remove`

### rerun

Stops and removes the containers, then performs run again

`./homebridge.sh rerun`

### attach

Attaches to the running container

`./homebridge.sh attach`

### logs

Diplays stdout log of the running container

`./homebridge.sh logs`

## Changelog
###0.11
moved from nodesource/jessie:5.6.0 to nodesource/jessie:5.8.0
moved files that are copied into the image are in directory ./image
moved configuration samtes to ./config-sample
simplified Dockerfile and combined the previously two script files into a single script
implemented a way to install homebridge modules at runtime without the need to include them in the docker image
fixing a locale issue with C vs UTF-8
###0.12
git push problem - do not use this release
###0.13
should have fixed git push problem
