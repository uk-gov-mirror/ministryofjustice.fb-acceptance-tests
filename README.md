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

You can visit ports on localhost to see the _Feature_ forms.

- http://localhost:5080 Email output
- http://localhost:5081 JSON output
- http://localhost:5082 "Save and return" module
- http://localhost:5083 Conditional steps

You can visit ports on localhost to see the _Component_ forms.

- http://localhost:3080 Autocomplete
- http://localhost:3081 Checkboxes
- http://localhost:3082 Date
- http://localhost:3083 Email
- http://localhost:3084 Fieldset
- http://localhost:3085 Number
- http://localhost:3086 Radios
- http://localhost:3087 Select
- http://localhost:3088 Text
- http://localhost:3089 Textarea
- http://localhost:3090 Upload

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
