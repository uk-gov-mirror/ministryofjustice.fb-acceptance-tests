# Form Builder Acceptance Tests

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

You can visit ports on localhost to see the _Form_ forms.

- http://localhost:5080 Email output
- http://localhost:5081 JSON output

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

Assuming an otherwise clean installation, the `make setup` target clones the dependent repositories and starts any services described in the `docker-compose.yml`. The `make spec` target executes the specs and leaves services running. The `make destroy` target deletes the dependent repositories and shuts down those services. 
