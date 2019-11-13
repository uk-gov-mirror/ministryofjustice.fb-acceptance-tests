setup: .runner .submitter .datastore .filestore .pdf-generator .service-token-cache

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.filestore:
	git clone git@github.com:ministryofjustice/fb-user-filestore.git .filestore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.submitter:
	git clone git@github.com:ministryofjustice/fb-submitter.git .submitter

.pdf-generator:
	git clone git@github.com:ministryofjustice/fb-pdf-generator.git .pdf-generator

.service-token-cache:
	git clone git@github.com:ministryofjustice/fb-service-token-cache.git .service-token-cache

destroy: .runner .submitter .datastore .filestore .pdf-generator .service-token-cache
	docker-compose down

stop:
	docker-compose down

build: stop setup
	echo HEAD > .runner/APP_SHA
	mkdir -p .runner/forms
	cp -r forms/* .runner/forms
	docker-compose build --build-arg BUNDLE_FLAGS='' --build-arg BUNDLE_ARGS='' --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_apps
	docker-compose exec service-token-cache-app sh -c "rails runner \"Support::ServiceTokenCache.put('slug', 'token-for-slug')\""
	docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3 mb s3://filestore-bucket"
	docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3api put-bucket-acl --bucket filestore-bucket --acl public-read"
	docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3 mb s3://external-filestore-bucket"
	docker-compose exec localstack sh -c "AWS_ACCESS_KEY_ID=qwerty AWS_SECRET_KEY=qwerty AWS_SECRET_ACCESS_KEY=qwerty aws --endpoint-url=http://localhost:4572 s3api put-bucket-acl --bucket external-filestore-bucket --acl public-read"

spec: serve
	docker-compose run acceptance-tests rspec

clean:
	rm -fr .runner .submitter .datastore .filestore .pdf-generator .service-token-cache
