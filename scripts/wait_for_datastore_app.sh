#!/bin/sh

until docker exec datastore-app wget http://localhost:3000/health -O - | grep healthy; do
    echo "Waiting for datastore-app to start accepting traffic...";
    sleep 1
done

echo "datastore-app accepting traffic";
