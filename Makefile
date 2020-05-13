platform:
	./integration/bin/platform --install --all

forms:
	./integration/bin/runner --remote
	cp -R .runner integration/.runner
	cp ./integration/tests.env.sample cp ./integration/tests.env

setup: platform forms start

start:
	docker-compose up -d
	sleep 5 # waiting for containers to spin up
	./integration/bin/post_install

stop:
	docker-compose down

build-tests:
	docker-compose up -d --build integration

spec-lib:
	docker-compose run integration bundle exec rspec spec/lib

spec-components:
	docker-compose run integration bundle exec rspec spec/components

spec-features:
	docker-compose run integration bundle exec rspec spec/features

spec: build-tests spec-lib spec-features spec-components
