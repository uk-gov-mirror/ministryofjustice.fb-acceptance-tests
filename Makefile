setup: .runner .submitter .datastore .pdf-generator

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.submitter:
	git clone git@github.com:ministryofjustice/fb-submitter.git .submitter

.pdf-generator:
	git clone git@github.com:ministryofjustice/fb-pdf-generator.git .pdf-generator

destroy: .runner .submitter .datastore .pdf-generator
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

spec: serve
	./scripts/wait_for_apps
	docker-compose run acceptance-tests rspec

clean:
	rm -fr .runner .submitter .datastore .pdf-generator
