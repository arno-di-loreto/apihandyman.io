# usage: create-docker-image.sh <image name> <version>
# example: create-docker-image.sh apihandyman/jekyll 4.1.0
# see serve.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


JEKYLL_VERSION=$2
IMAGE_NAME=$1:$JEKYLL_VERSION
# TODO multi platform build
if [[ $(uname -m) == 'arm64' ]]; then
  echo "Building custom jekyll arm image"
  # Building custom image for arm platform because running x86 one on arm is ultra slow
  SOURCE_IMAGE_NAME=custom-jekyll-arm64
  docker build --build-arg JEKYLL_VERSION=$JEKYLL_VERSION -t "$SOURCE_IMAGE_NAME:$JEKYLL_VERSION" $SCRIPT_DIR 
  docker images -a
else
  SOURCE_IMAGE_NAME=jekyll/jekyll
fi
echo "Building apihandyman jekyll image with plugins already installed"
CONTAINER_NAME=jekyll_tmp
docker run \
  --name $CONTAINER_NAME \
  --volume="$PWD:/srv/jekyll:delegated" \
  -it $SOURCE_IMAGE_NAME:$JEKYLL_VERSION \
  bundle install
echo "Commit image $IMAGE_NAME"
docker commit $CONTAINER_NAME $IMAGE_NAME 
echo "Cleaning $CONTAINER_NAME"
docker rm $CONTAINER_NAME