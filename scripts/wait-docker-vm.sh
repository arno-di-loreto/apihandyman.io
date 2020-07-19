
DOCKER_IS_NOT_RUNNING=1
while [[ DOCKER_IS_NOT_RUNNING -eq 1 ]];
do
    if [[ `docker ps 2>/dev/null` ]];
    then
        echo "Docker VM is started"
        DOCKER_IS_NOT_RUNNING=0
    else
        echo "Waiting for docker VM to start"
        sleep 10
    fi
done