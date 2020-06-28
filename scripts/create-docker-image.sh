# usage: create-docker-image.sh <image name> <version>
# example: create-docker-image.sh apihandyman/jekyll 4.1.0
# see serve.sh
JEKYLL_VERSION=$2
JEKYLL_DOCKER_VERSION=latest
IMAGE_NAME=$1:$JEKYLL_VERSION
CONTAINER_NAME=jekyll_tmp
docker run \
  --name $CONTAINER_NAME \
  --volume="$PWD:/srv/jekyll:delegated" \
  -it jekyll/jekyll:$JEKYLL_DOCKER_VERSION \
  bundle install
docker commit $CONTAINER_NAME $IMAGE_NAME 
docker rm $CONTAINER_NAME