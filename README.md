# Fb Acceptance tests

This is a repo that spin up the form builder platform containers.

1. Submitter
2. Filestore
3. Datastore
4. Service token cache
5. Pdf generator

## Clone

    $ git clone git@github.com:ministryofjustice/fb-acceptance-tests.git

Install dependencies with:

    $ bundle

## Install dependencies

    $ brew cask install chromedriver chromium

## Run acceptance tests using runner from github

    $ ./bin/acceptance-tests --run

## Run acceptance tests using local runner

    $ ./bin/acceptance-tests --run --local

### Setup all containers

    $ ./bin/platform --install --all

### Update a specific container

The following command will just rebuild the container:

    $ ./bin/platform --submitter

## Local

There are times when we made a change and we want to update the local

The following command will install a copy local submitter and rebuild the container:

    $ ./bin/platform --submitter-local --install

The following command will only rebuild the container:

    $ ./bin/platform --submitter-local

## Remote

The following command will install a copy of submitter from github and
rebuild the container:

    $ ./bin/platform --submitter --install

## Help

For other options run:

    $ ./bin/platform --help

## Configuration file

In order for the repo knows the container name and the github repo, it was
create with a config file as fundamental. For more details see
config_file.rb.sample.

## Testing

And then execute:

    $ bundle exec rspec

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
