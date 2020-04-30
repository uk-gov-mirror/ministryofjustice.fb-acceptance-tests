stop:
	docker-compose down

destroy:
	./bin/teardown

build:
	bundle install

serve:
	./bin/platform-build --all
	./bin/forms --remote
	foreman start

spec: build serve
	rspec spec
