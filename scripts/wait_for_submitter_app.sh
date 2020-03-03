#!/bin/sh

until docker exec submitter-app wget http://localhost:3000/health -O - | grep healthy; do
    echo "Waiting for submitter-app to start accepting traffic...";
    sleep 1
done

echo "submitter-app accepting traffic";
