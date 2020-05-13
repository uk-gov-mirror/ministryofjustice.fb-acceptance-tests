platform:
	./integration/bin/platform --install --all

services:
	cp Procfil* .runner
	cp Dockerfile.forms .runner
	cp Gemfile .runner/Gemfile
	cp -R ./integration .runner/integration
	cp -R forms .runner/integration
	docker-compose up -d --build services
#	./integration/bin/runner --remote

setup: platform services acceptance-tests start

start:
	docker-compose up -d
	sleep 5 # waiting for containers to spin up
	./integration/bin/post_install

stop:
	docker-compose down

acceptance-tests:
	cp integration/tests.env.local integration/tests.env
	docker-compose up -d --build integration

spec-lib:
	docker-compose run integration bundle exec rspec spec/lib

spec-components:
	docker-compose run integration bundle exec rspec spec/components

spec-features:
	docker-compose run integration bundle exec rspec spec/features

spec: spec-lib spec-features spec-components
