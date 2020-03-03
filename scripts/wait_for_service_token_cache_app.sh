#!/bin/sh

until docker exec service-token-cache-app wget http://localhost:3000/health -O - | grep healthy; do
    echo "Waiting for service-token-cache-app to start accepting traffic...";
    sleep 1
done

echo "service-token-cache-app accepting traffic";
