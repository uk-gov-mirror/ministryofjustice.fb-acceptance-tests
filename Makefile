setup: .runner .features .components .submitter .datastore .filestore .pdf-generator .service-token-cache

.datastore:
	git clone git@github.com:ministryofjustice/fb-user-datastore.git .datastore

.filestore:
	git clone git@github.com:ministryofjustice/fb-user-filestore.git .filestore

.runner:
	git clone git@github.com:ministryofjustice/fb-runner-node.git .runner

.features: make-features copy-features

.components: make-components copy-components

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

make-components:
	mkdir -p .components/autocomplete
	mkdir -p .components/checkboxes
	mkdir -p .components/date
	mkdir -p .components/email
	mkdir -p .components/fieldset
	mkdir -p .components/number
	mkdir -p .components/radios
	mkdir -p .components/select
	mkdir -p .components/text
	mkdir -p .components/textarea
	mkdir -p .components/upload

copy-components:
	cp -r .runner/* .components/autocomplete
	cp -r .runner/* .components/checkboxes
	cp -r .runner/* .components/date
	cp -r .runner/* .components/email
	cp -r .runner/* .components/fieldset
	cp -r .runner/* .components/number
	cp -r .runner/* .components/radios
	cp -r .runner/* .components/select
	cp -r .runner/* .components/text
	cp -r .runner/* .components/textarea
	cp -r .runner/* .components/upload

stop:
	docker-compose down

build: stop setup
	echo HEAD > .features/email-output/APP_SHA
	mkdir -p .features/email-output/form
	cp -r ./forms/features/email-output/* .features/email-output/form
	echo HEAD > .features/json-output/APP_SHA
	mkdir -p .features/json-output/form
	cp -r ./forms/features/json-output/* .features/json-output/form
	echo HEAD > .features/save-and-return-module/APP_SHA
	mkdir -p .features/save-and-return-module/form
	cp -r ./forms/features/save-and-return-module/* .features/save-and-return-module/form
	
	echo HEAD > .components/autocomplete/APP_SHA
	mkdir -p .components/autocomplete/form
	cp -r ./forms/components/autocomplete/* .components/autocomplete/form
	echo HEAD > .components/checkboxes/APP_SHA
	mkdir -p .components/checkboxes/form
	cp -r ./forms/components/checkboxes/* .components/checkboxes/form
	echo HEAD > .components/date/APP_SHA
	mkdir -p .components/date/form
	cp -r ./forms/components/date/* .components/date/form
	echo HEAD > .components/email/APP_SHA
	mkdir -p .components/email/form
	cp -r ./forms/components/email/* .components/email/form
	echo HEAD > .components/fieldset/APP_SHA
	mkdir -p .components/fieldset/form
	cp -r ./forms/components/fieldset/* .components/fieldset/form
	echo HEAD > .components/number/APP_SHA
	mkdir -p .components/number/form
	cp -r ./forms/components/number/* .components/number/form
	echo HEAD > .components/radios/APP_SHA
	mkdir -p .components/radios/form
	cp -r ./forms/components/radios/* .components/radios/form
	echo HEAD > .components/select/APP_SHA
	mkdir -p .components/select/form
	cp -r ./forms/components/select/* .components/select/form
	echo HEAD > .components/text/APP_SHA
	mkdir -p .components/text/form
	cp -r ./forms/components/text/* .components/text/form
	echo HEAD > .components/textarea/APP_SHA
	mkdir -p .components/textarea/form
	cp -r ./forms/components/textarea/* .components/textarea/form
	echo HEAD > .components/upload/APP_SHA
	mkdir -p .components/upload/form
	cp -r ./forms/components/upload/* .components/upload/form
	
	docker-compose build --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_features_apps.sh
	./scripts/wait_for_components_apps.sh
	./scripts/setup_test_env.sh

spec: .features .components serve
	docker-compose run tests bundle exec rspec

clean:
	rm -rf .runner .features .components .submitter .datastore .filestore .pdf-generator .service-token-cache
