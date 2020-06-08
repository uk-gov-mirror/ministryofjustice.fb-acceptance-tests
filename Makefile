platform-clone:
	./integration/bin/platform --install --all --no-build

# platform clone is needed because docker compose read the docker-compose.yml
# and complains that the context for other containers doesn't exist
services: platform-clone
	./integration/bin/runner --remote
	$(MAKE) services-post-install
	$(MAKE) services-build

services-post-install:
	cp Procfil* .runner
	cp Dockerfile.forms .runner
	cp Gemfile .runner/Gemfile
	cp -R ./integration/ .runner/integration/
	cp -R forms/ .runner/forms/
	echo HEAD > .runner/APP_SHA

services-build:
	docker-compose up -d --build services

services-post-build:
	./integration/bin/wait_for_services

services-local:
	./integration/bin/runner --local
	$(MAKE) services-post-install
	$(MAKE) services-build
	$(MAKE) services-post-build

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

submitter-refresh:
	./integration/bin/platform --update submitter --no-build

datastore-refresh:
	./integration/bin/platform --update datastore --no-build

pdf-generator-referesh:
	./integration/bin/platform --update pdf-generator --no-build

filestore-refresh:
	./integration/bin/platform --update filestore --no-build

service-token-cache-refresh:
	./integration/bin/platform --update service-token-cache --no-build

platform-post-install:
	./integration/bin/wait_for_platform
	./integration/bin/post_install

services-refresh:
	docker-compose up -d --build services
	$(MAKE) services-post-build

local-env-vars:
	cp integration/tests.env.local integration/tests.env

prepare: local-env-vars
	docker-compose up -d --build integration
	$(MAKE) services-post-build

## Experimental ##
ci-env-vars:
	cp integration/tests.env.ci integration/tests.env

## Experimental ##
start-ci: ci-env-vars
	docker-compose -f docker-compose.ci.yml up -d --build integration

setup-ci: start-ci

setup: services platform prepare

setup-local: services-local platform-local prepare

start:
	docker-compose up -d
	$(MAKE) platform-post-install
	$(MAKE) services-post-build

stop:
	docker-compose down

restart:
	$(MAKE) stop
	$(MAKE) start

spec:
	docker-compose run integration bundle exec rspec spec

feature:
ifndef FEATURE
	$(error FEATURE is required)
endif
	docker-compose run integration bundle exec rspec spec/features/$(FEATURE)_spec.rb

component:
ifndef COMPONENT
	$(error COMPONENT is required)
endif
	docker-compose run integration bundle exec rspec spec/components/$(COMPONENT)_spec.rb

## Experimental ##
spec-ci:
	docker-compose -f docker-compose.ci.yml run integration bundle exec rspec spec/components/text_spec.rb
