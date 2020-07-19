# Using custom image containing all apihandyman.io gems 
# as gems caching not working with
# standard jekyll image when version > 3.8.5
# And don't want to download gems on each startup as they
# don't change often

JEKYLL_VERSION=4.1.0
JEKYLL_DOCKER_IMAGE_NAME=apihandyman/jekyll

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JEKYLL_DOCKER_IMAGE=$JEKYLL_DOCKER_IMAGE_NAME:$JEKYLL_VERSION

# Waiting for docker VM (take a few seconds to start after Macbook reboot)
$SCRIPT_DIR/wait-docker-vm.sh

# Creating custom docker image if necessary

if [[ `docker image ls $JEKYLL_DOCKER_IMAGE | wc -l` -eq 1 ]]
then
  echo "Docker image $JEKYLL_DOCKER_IMAGE does not exist, creating it"
  $SCRIPT_DIR/create-docker-image.sh $JEKYLL_DOCKER_IMAGE_NAME $JEKYLL_VERSION
else
  echo "Docker image $JEKYLL_DOCKER_IMAGE exists, using it"
fi

RUNNING_CONTAINER=`docker ps -f ancestor="$JEKYLL_DOCKER_IMAGE" --format "{{.ID}}"`
# Starting container if not already started
if [[ -z $RUNNING_CONTAINER ]]
then
  echo "Starting Docker container"
  docker run --rm \
    -p 4000:4000 \
    -p 35729:35729 \
    --volume="$PWD:/srv/jekyll:delegated" \
    -it $JEKYLL_DOCKER_IMAGE \
    jekyll serve --host 0.0.0.0 --incremental --livereload
# Attaching to running container (happen if vs code stopped without stopping container)
else
  echo "Docker container already started, attaching to it"
  docker attach $RUNNING_CONTAINER
fi