SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
COLLECTION_DIR=$SCRIPT_DIR

# Waiting for docker VM (take a few seconds to start after Macbook reboot)
$SCRIPT_DIR/wait-docker-vm.sh

#newman run --global-var token=$CLOUDFLARE_TOKEN --global-var website=$CLOUDFLARE_WEBSITE ../scripts/cloudflare-clearcache.postman_collection.json 
docker run -v $COLLECTION_DIR:/etc/newman -t postman/newman:alpine run --global-var token=$CLOUDFLARE_TOKEN --global-var website=$CLOUDFLARE_WEBSITE cloudflare-clearcache.postman_collection.json