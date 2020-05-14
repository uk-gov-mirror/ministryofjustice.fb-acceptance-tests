platform-clone:
	./integration/bin/platform --install --all --no-build

platform:
	./integration/bin/platform --submitter --filestore --datastore --pdf-generator --service-token-cache
	$(MAKE) platform-post-install

## Everything in one. Better for performance.
platform-local:
	./integration/bin/platform --install --submitter-local --filestore-local --datastore-local --pdf-generator-local --service-token-cache-local
	$(MAKE) platform-post-install

submitter-local:
	./integration/bin/platform --install --submitter-local

datastore-local:
	./integration/bin/platform --install --datastore-local

pdf-generator-local:
	./integration/bin/platform --install --pdf-generator-local

filestore-local:
	./integration/bin/platform --install --filestore-local
	$(MAKE) platform-post-install

service-token-cache-local:
	./integration/bin/platform --install --service-token-cache-local
	$(MAKE) platform-post-install

platform-post-install:
	./integration/bin/wait_for_platform
	./integration/bin/post_install

# platform clone is needed because docker compose read the docker-compose.yml
# and complains that the context for other containers doesn't exist
services: platform-clone
	./integration/bin/runner --remote
	$(MAKE) services-post-install
	$(MAKE) services-build

services-local:
	./integration/bin/runner --local
	$(MAKE) services-post-install
	$(MAKE) services-build

services-post-install:
	cp Procfil* .runner
	cp Dockerfile.forms .runner
	cp Gemfile .runner/Gemfile
	cp -R ./integration .runner/integration
	cp -R forms .runner/forms
	echo HEAD > .runner/APP_SHA

services-build:
	docker-compose up -d --build services

services-refresh:
	docker-compose up -d --build services
	./integration/bin/wait_for_services

local-env-vars:
	cp integration/tests.env.local integration/tests.env

# This is repetead because of performance.
start: local-env-vars
	docker-compose up -d --build integration
	./integration/bin/wait_for_services

## Experimental ##
ci-env-vars:
	cp integration/tests.env.ci integration/tests.env

## Experimental ##
start-ci: ci-env-vars
	docker-compose -f docker-compose.ci.yml up -d --build integration

setup-ci: start-ci

setup: services platform start

setup-local: services-local platform-local start

stop:
	docker-compose down

spec:
	docker-compose run integration bundle exec rspec spec

## Experimental ##
spec-ci:
	docker-compose -f docker-compose.ci.yml run integration bundle exec rspec spec/components/text_spec.rb
