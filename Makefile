serve: clone-integration
	cd .integration && bundle install
	&& ./bin/platform --install --all
