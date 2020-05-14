#!/bin/sh

docker rm $(docker ps -q -f 'status=exited') 2> /dev/null
docker rmi $(docker images -q -f "dangling=true") 2> /dev/null

# Exit cleanly
exit 0