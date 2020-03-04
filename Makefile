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
	./scripts/make_features.sh

copy-features:
	./scripts/copy_features.sh

stop:
	docker-compose down
	./scripts/teardown.sh

build: stop setup
	./scripts/setup_features.sh
	docker-compose build --parallel

serve: build
	docker-compose up -d
	./scripts/wait_for_features_apps.sh
	./scripts/setup_test_env.sh

spec: .features serve
	docker-compose run tests bundle exec rspec

clean:
	rm -fr .runner .features .submitter .datastore .filestore .pdf-generator .service-token-cache
