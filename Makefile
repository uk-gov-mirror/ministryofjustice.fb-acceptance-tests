setup: .runner .features .submitter .datastore .filestore .pdf-generator .service-token-cache

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.filestore:
	git clone git@github.com:ministryofjustice/fb-user-filestore.git .filestore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.features: make-features copy-features

.submitter:
	git clone git@github.com:ministryofjustice/fb-submitter.git .submitter

.pdf-generator:
	git clone git@github.com:ministryofjustice/fb-pdf-generator.git .pdf-generator

.service-token-cache:
	git clone git@github.com:ministryofjustice/fb-service-token-cache.git .service-token-cache

destroy: stop clean

make-features:
	mkdir -p .features/email-output
	mkdir -p .features/json-output
	mkdir -p .features/save-and-return-module

copy-features:
	cp -r .runner/* .features/email-output
	cp -r .runner/* .features/json-output
	cp -r .runner/* .features/save-and-return-module

stop:
	docker-compose down

build: stop setup
	echo HEAD > .features/email-output/APP_SHA
	mkdir -p .features/email-output/form
	cp -r ./forms/email-output/* .features/email-output/form
	echo HEAD > .features/json-output/APP_SHA
	mkdir -p .features/json-output/form
	cp -r ./forms/json-output/* .features/json-output/form
	echo HEAD > .features/save-and-return-module/APP_SHA
	mkdir -p .features/save-and-return-module/form
	cp -r ./forms/save-and-return-module/* .features/save-and-return-module/form
	docker-compose build --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_apps.sh
	./scripts/setup_test_env.sh

spec: .features serve
	docker-compose run tests bundle exec rspec

clean:
	rm -fr .runner .features .submitter .datastore .filestore .pdf-generator .service-token-cache
