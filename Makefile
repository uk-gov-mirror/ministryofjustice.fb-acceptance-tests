platform:
	./integration/bin/platform --install --all

runner-remote:
	./integration/bin/runner --remote
	cp -R .runner integration

setup: platform runner-remote
	docker-compose up -d --build integration

stop:
	docker-compose down

spec:
	docker-compose up -d --build integration
	docker-compose run integration bundle exec rspec spec
