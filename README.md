
# synology-docker-homebridge

Docker image of Homebrigde for running on a Synology NAS

For details on Homebridge, see https://github.com/nfarina/homebridge

This is a Docker enabled version of Homebridge designed to run on a Synology NAS from https://github.com/nfarina/homebridge and built from https://github.com/cbrandlehner/homebridge-docker version. I am running a Synology 1815+ and DSM 6.0-7321.

The Docker image has already been built and is on the Docker Hub repository at https://hub.docker.com/r/psmith/synology-docker-homebridge/ 
You can search for it from the Synology Docker console Registry and load the image directly to your NAS.

On your Synology NAS, create a "docker/homebridge" folder. After creating your config.json and package.json files, copy them to the shared "docker/homebridge" folder. The config.json will have your homebridge config and the package.json will list the NPM packages that you want to be built each time the container is run. You do not have to build a new image everytime you want to add plugins! See https://github.com/psmith3/synology-docker-homebridge/tree/master/config-sample for samples of both the config.json, package.json and homebridge_start.sh files. If you make any changes to the config.json or package.json files, you will need to restsart homebridge for the settings to take.

Run the container from the `homebridge_start.sh` via the Synology Task Scheduler in Coltrol Panel or via SSH command line by entering

`sudo docker run --name=homebridge -d --restart=always --net=host -p 51826:51826 -v /volume1/docker/homebridge:/root/.homebridge psmith/synology-docker-homebridge:0.13`

Enter your root password to run the command.

If you want to use Synology Task Scheduler in the Control Panel of the NAS, you will need to copy `homebridge_start.sh` to the "docker/homebridge" folder on the shared volume. Next, create a task that runs the `docker/homebridge/homebridge_start.sh` at bootup and optionally, I have another that restarts the container at 1:45am everynight. This is not neccesary, but in my earlier testing, I often rebooted and just built the task to keep it all clean. For the tasks, you will need to make the task user `root`.

If you are running the firewall on the Synology, you will need to open TCP 5353 & 51826. You could select from a list of built-in applications and select "Docker homebridge 51826 Docker (TCP)" and "Bonjour 5353 Bonjour Service" You can find the firwall profiles under the Control Panel/Security. If you do not open these ports, the firewall will close within a few minutes and your app will not be reachable from an IOS device.

##Plugins
You can find all of the plugins on NPM at https://www.npmjs.com/search?q=homebridge+plugin 

## Configuration
Copy `config-sample.json` to `config.json` and adapt to your likings.

To build your own Docker images, follow these commands:

## Build
`./homebridge.sh build`

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
