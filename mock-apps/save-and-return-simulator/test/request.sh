set -x

curl -i \
    -H "Accept: application/json" \
    -X POST -d '{ "message": { "to": "user@example.com", "subject": "subject goes here", "body": "body as string goes here","template_name": "name-of-template","[extra_personalisation]": {  "token": "my-token" }}}' \
    http://localhost:3005/email

curl -i -H "Accept: application/json" -X GET http://localhost:3005/email
