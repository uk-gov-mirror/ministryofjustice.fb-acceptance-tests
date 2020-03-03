#!/bin/sh

until docker exec filestore-app wget http://localhost:3000/health -O - | grep healthy; do
    echo "Waiting for filestore-app to start accepting traffic...";
    sleep 1
done

echo "filestore-app accepting traffic";
