platform:
	./integration/bin/platform --install --all

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
	docker-compose up -d --build services
	docker-compose up -d --build integration
	./integration/bin/wait_for_platform
	./integration/bin/post_install
	./integration/bin/wait_for_services
	./integration/bin/runner --status

stop:
	docker-compose down

spec-lib:
	docker-compose run integration bundle exec rspec spec/lib

spec-components:
	docker-compose run integration bundle exec rspec spec/components

spec-features:
	docker-compose run integration bundle exec rspec spec/features

spec: spec-lib spec-components spec-features
