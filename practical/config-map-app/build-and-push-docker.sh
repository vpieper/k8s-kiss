set -e

DOCKER_HUB_USERNAME=$1
DOCKER_HUB_PASSWORD=$2

docker login -u "$DOCKER_HUB_USERNAME" -p "$DOCKER_HUB_PASSWORD"
docker build . -t config-map-app
docker tag config-map-app "$DOCKER_HUB_USERNAME"/config-map-app:v1
docker push "$DOCKER_HUB_USERNAME"/config-map-app:v1
