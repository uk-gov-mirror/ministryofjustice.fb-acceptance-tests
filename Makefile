platform:
	./integration/bin/platform --install --all

forms:
	./integration/bin/runner --remote
	cp -R .runner integration

setup: platform forms start

start:
	docker-compose up -d --build integration

stop:
	docker-compose down

spec-lib:
	docker-compose run integration bundle exec rspec spec/lib

spec-components:
	docker-compose run integration bundle exec rspec spec/components

spec-features:
	docker-compose run integration bundle exec rspec spec/features

spec: spec-lib spec-features spec-components
