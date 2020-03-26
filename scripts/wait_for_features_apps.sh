#!/bin/sh

# Health on port 3000
until docker exec pdf-generator wget http://localhost:3000/health -O - | grep healthy; do
    echo "Waiting for pdf-generator to start accepting traffic...";
    sleep 1
done

# Health on port 8080
until docker exec output-recorder wget http://localhost:8080/health -O - | grep healthy; do
    echo "Waiting for output-recorder to start accepting traffic...";
    sleep 1
done

# Ping
for app in features-email-app features-json-app features-save-and-return-app features-conditional-steps-app features-maintenance-mode-app; do
    until docker exec $app wget http://localhost:3000/ping.json -O - | grep APP_SHA; do
        echo "Waiting for ${app} to start accepting traffic...";
        sleep 1
    done
done

echo "features apps accepting traffic";
