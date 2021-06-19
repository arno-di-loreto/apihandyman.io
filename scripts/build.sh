JEKYLL_VERSION=4.1.0
JEKYLL_DOCKER_IMAGE_NAME=jekyll/builder
JEKYLL_DOCKER_IMAGE=$JEKYLL_DOCKER_IMAGE_NAME:$JEKYLL_VERSION

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

# Waiting for docker VM (take a few seconds to start after Macbook reboot)
$SCRIPT_DIR/wait-docker-vm.sh

docker run \
        -v $ROOT_DIR:/srv/jekyll \
        -v $ROOT_DIR/_site_publish:/srv/jekyll/_site \
        $JEKYLL_DOCKER_IMAGE /bin/bash -c "chmod -R 777 /srv/jekyll && jekyll build --future"