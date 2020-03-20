#!/bin/sh

echo HEAD > .features/email-output/APP_SHA
mkdir -p .features/email-output/form
cp -r ./forms/features/email-output/* .features/email-output/form

echo HEAD > .features/json-output/APP_SHA
mkdir -p .features/json-output/form
cp -r ./forms/features/json-output/* .features/json-output/form

echo HEAD > .features/save-and-return-module/APP_SHA
mkdir -p .features/save-and-return-module/form
cp -r ./forms/features/save-and-return-module/* .features/save-and-return-module/form

echo HEAD > .features/conditional-steps/APP_SHA
mkdir -p .features/conditional-steps/form
cp -r ./forms/features/conditional-steps/* .features/conditional-steps/form

mkdir -p .features/conditional-steps/form
cp -r ./forms/features/conditional-steps/* .features/maintenance-mode/form
