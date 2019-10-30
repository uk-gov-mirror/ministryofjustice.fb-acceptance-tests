# Form Builder Acceptance Tests

This will spin up the Form Builder environment locally for regression testing and debugging.

## Usage

### Setup

Run the following command to clone all the needed repositories

```
make setup
```

### Serve locally

```
make serve
```

You can now visit http://localhost:3000 to see the test form

### Run acceptance specs

```
make spec
```

This will ensure that the contents filled into the form fields are contained in the PDF email attachment.

## TODO
- Hook into CI
