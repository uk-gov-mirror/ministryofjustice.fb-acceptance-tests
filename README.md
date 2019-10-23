# Form Builder Acceptance Tests

This will spin up the Form Builder environment locally for regression testing and debugging.

## Usage
### Serve locally

```
make serve
```

You can now visit http://localhost:3003 to see the test form

### Run acceptance specs

```
make spec
```

This will ensure that the contents filled into the form fields are contained in the PDF email attachment.

## TODO
- Hook into CI
