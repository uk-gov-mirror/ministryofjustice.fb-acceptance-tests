# Fb Acceptance tests

This is a repo that run all of our acceptance tests.

## Clone

    $ git clone git@github.com:ministryofjustice/fb-acceptance-tests.git

Install dependencies with:

    $ bundle

### Setup all containers

The following command will spin up all form builder platform containers and
services. It takes approximatelly 13 minutes:

    $ make setup

### Run the tests

After all containers are setup, you can run the tests:

    $ make spec

### Setup the tests to run to point to the test environment

    $ make setup-ci && make spec-ci

## Useful commands

### Start, stop, restart

Commands to start, stop or restart the containers:

    $ make start
    $ make stop
    $ make restart

### Features and Components

It is possible to fun a set of feature or component specs instead of the whole suite:

    $ make feature FEATURE=save_and_return_module

or

    $ make component COMPONENT=autocomplete

Available features:

- conditional_steps
- email_output
- json_output
- maintenance_mode
- save_and_return_module

Available components:

- autocomplete
- checkboxes
- conditionals_and_upload
- date
- email
- fieldset
- number
- radios
- select
- text
- textarea
- upload

## Glossary

The acceptance tests uses a glossary of terms:

1. Platform
2. Services

### Platform

The following are the apps that we have on our platform:

1. Submitter
2. Filestore
3. Datastore
4. Service token cache
5. Pdf generator

### Services

The services layer contain N forms with the Runner booting up them.

### Update a specific container

The following command will just rebuild the container:

    $ ./bin/platform --submitter

Or in case of the services:

    $ make services-refresh

## Local

There are times when we made a change and we want to test against our changes.

The following command will install a copy local submitter from your '..' directory,
so please make sure the path is right before running the command:

    $ ls ../fb-submitter # you should have submitter code here
    $ make submitter-local

## Remote

The following command will install a copy of submitter from github and
rebuild the container:

    $ make submitter

This applies for all other containers in the platform (e.g make filestore, etc).

## Configuration file

There is a configuration file which contain information about where to locate
what repos to clone and the container names to build.
This is done automagically but for more details see
integration/config_file.rb.sample.

## Output recorder

There is a script that shows the amount of emails or json requests
send by the submitter, which the output recorder did record. You can run:

    $ ./integration/bin/output-recorder

## Submitter failed jobs

There is a script that shows the amount of jobs that failed to process during
the tests. The tests will output this but you can also run if you like:

    $ ./integration/bin/submitter-failed-jobs
