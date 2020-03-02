setup: .runner .forms .submitter .datastore .filestore .pdf-generator .service-token-cache

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.filestore:
	git clone git@github.com:ministryofjustice/fb-user-filestore.git .filestore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.forms: make-forms copy-forms

.submitter:
	git clone git@github.com:ministryofjustice/fb-submitter.git .submitter

.pdf-generator:
	git clone git@github.com:ministryofjustice/fb-pdf-generator.git .pdf-generator

.service-token-cache:
	git clone git@github.com:ministryofjustice/fb-service-token-cache.git .service-token-cache

destroy: stop clean

make-forms:
	mkdir -p .forms/email-output
	mkdir -p .forms/json-output
	mkdir -p .forms/save-and-return-module

copy-forms:
	cp -r .runner/* .forms/email-output
	cp -r .runner/* .forms/json-output
	cp -r .runner/* .forms/save-and-return-module

stop:
	docker-compose down

build: stop setup
	echo HEAD > .forms/email-output/APP_SHA
	mkdir -p .forms/email-output/form
	cp -r ./forms/email-output/* .forms/email-output/form
	echo HEAD > .forms/json-output/APP_SHA
	mkdir -p .forms/json-output/form
	cp -r ./forms/json-output/* .forms/json-output/form
	echo HEAD > .forms/save-and-return-module/APP_SHA
	mkdir -p .forms/save-and-return-module/form
	cp -r ./forms/save-and-return-module/* .forms/save-and-return-module/form
	docker-compose build --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_apps.sh
	./scripts/setup_test_env.sh

spec: serve
	docker-compose run tests bundle exec rspec

clean:
	rm -fr .runner .forms .submitter .datastore .filestore .pdf-generator .service-token-cache
