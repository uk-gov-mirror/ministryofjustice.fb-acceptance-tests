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
	./scripts/make_features.sh

copy-features:
	./scripts/copy_features.sh

make-components:
	./scripts/make_components.sh

copy-components:
	./scripts/copy_components.sh

stop:
	docker-compose down

build: stop setup
	./scripts/setup_features.sh
	./scripts/setup_components.sh
	docker-compose build --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_datastore_app.sh
	./scripts/wait_for_filestore_app.sh
	./scripts/wait_for_submitter_app.sh
	./scripts/wait_for_service_token_cache_app.sh
	./scripts/wait_for_features_apps.sh
	./scripts/wait_for_components_apps.sh
	./scripts/setup_test_env.sh

spec: .features .components serve
	docker-compose run tests bundle exec rspec

clean:
	rm -rf .runner .features .components .submitter .datastore .filestore .pdf-generator .service-token-cache
