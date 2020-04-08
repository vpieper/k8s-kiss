set -e

DOCKER_HUB_USERNAME=$1
DOCKER_HUB_PASSWORD=$2

cd ./config-map-app
./build-and-push-docker.sh  $DOCKER_HUB_USERNAME $DOCKER_HUB_PASSWORD

cd ../environment-variable-app
./build-and-push-docker.sh  $DOCKER_HUB_USERNAME $DOCKER_HUB_PASSWORD