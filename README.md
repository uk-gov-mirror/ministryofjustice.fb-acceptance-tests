# Form Builder Feature and Component Acceptance Tests

This will spin up the Form Builder environment for regression testing and debugging.

## Usage

### Setup

Run the following command to clone all the necessary repositories:

```
make setup
```

### Serve

```
make serve
```

You can visit ports on localhost to see the _services_.

- [10001](http://localhost:10001) Datastore
- [10002](http://localhost:10002) Filestore
- [10003](http://localhost:10003) Submitter

You can visit ports on localhost to see the _Feature_ forms.

- [3080](http://localhost:3080) Email output
- [3081](http://localhost:3081) JSON output
- [3082](http://localhost:3082) "Save and return" module
- [3083](http://localhost:3083) Conditional steps

You can visit ports on localhost to see the _Component_ forms.

- [5080](http://localhost:5080) Autocomplete
- [5081](http://localhost:5081) Checkboxes
- [5082](http://localhost:5082) Date
- [5083](http://localhost:5083) Email
- [5084](http://localhost:5084) Fieldset
- [5085](http://localhost:5085) Number
- [5086](http://localhost:5086) Radios
- [5087](http://localhost:5087) Select
- [5088](http://localhost:5088) Text
- [5089](http://localhost:5089) Textarea
- [5090](http://localhost:5090) Upload

### Run acceptance specs

```
make spec
```

### Ensuring dependent repositories are up-to-date

`make setup` clones the `HEAD` from the `master` branch of dependent repositories to your development environment.

To delete them and clone them again run:

```sh
make clean setup
```

To delete them without cloning them again run:

```sh
make destroy
```

Assuming an otherwise clean installation, the `make setup` target clones the dependent repositories. The `make spec` target starts any services described in the `docker-compose.yml` and executes the specs, leaving services running. The `make destroy` target shuts down those services and deletes the dependent repositories from your development environment.
