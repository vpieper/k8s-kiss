set -e

DOCKER_HUB_USERNAME=$1
DOCKER_HUB_PASSWORD=$2

docker login -u "$DOCKER_HUB_USERNAME" -p "$DOCKER_HUB_PASSWORD"
docker build . -t quotes-app
docker tag quotes-app "$DOCKER_HUB_USERNAME"/quotes-app:v1
docker push "$DOCKER_HUB_USERNAME"/quotes-app:v1
