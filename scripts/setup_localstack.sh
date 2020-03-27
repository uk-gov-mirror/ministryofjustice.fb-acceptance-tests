#!/bin/sh

set -ex

until docker exec localstack wget http://localhost:8080/health -O - | grep '{"status":"OK"}'; do
  echo "Waiting for localstack to start accepting traffic...";
  sleep 1
done

docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3 mb s3://filestore-bucket"
docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3api put-bucket-acl --bucket filestore-bucket --acl public-read"
docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3 mb s3://external-filestore-bucket"
docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3api put-bucket-acl --bucket external-filestore-bucket --acl public-read"
