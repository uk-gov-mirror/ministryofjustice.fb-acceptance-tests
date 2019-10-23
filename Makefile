setup: .runner .submitter .test-form .datastore .pdf-generator

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.submitter:
	git clone git@github.com:ministryofjustice/fb-submitter.git .submitter

.test-form:
	git clone git@github.com:emileswarts/fb-hmcts-complaints.git .test-form

.pdf-generator:
	git clone git@github.com:ministryofjustice/fb-pdf-generator.git .pdf-generator

destroy: .runner .submitter .test-form .datastore .pdf-generator
	docker-compose down

stop:
	docker-compose down

build: setup
	echo HEAD > .runner/APP_SHA
	docker-compose build --build-arg BUNDLE_FLAGS='' --build-arg BUNDLE_ARGS='' --parallel

serve: build
	docker-compose up -d submitter-db datastore-db runner-app fake-inbox pdf-generator
	./scripts/wait_for_db datastore-db postgres && ./scripts/wait_for_db submitter-db postgres
	docker-compose up -d submitter-app submitter-worker datastore-app

spec: serve
	docker-compose run acceptance-tests rspec

clean:
	rm -fr .runner .submitter .test-form .datastore .pdf-generator
