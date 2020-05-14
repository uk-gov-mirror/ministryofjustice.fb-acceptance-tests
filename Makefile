platform:
	./integration/bin/platform --install --all
	./integration/bin/wait_for_platform
	./integration/bin/post_install

services:
	./integration/bin/runner --remote
	cp Procfil* .runner
	cp Dockerfile.forms .runner
	cp Gemfile .runner/Gemfile
	cp -R ./integration .runner/integration
	cp -R forms .runner/forms
	echo HEAD > .runner/APP_SHA

services-refresh:
	docker-compose up -d --build services
	./integration/bin/wait_for_services

setup: services platform start

local-env-vars:
	cp integration/tests.env.local integration/tests.env

# This is repetead because of performance.
start: local-env-vars
	docker-compose build --parallel services integration
	docker-compose up -d services integration
	./integration/bin/wait_for_services

stop:
	docker-compose down

spec:
	docker-compose run integration bundle exec rspec spec

tests:
	docker-compose up -d --build integration
