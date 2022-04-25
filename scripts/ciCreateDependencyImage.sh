#!/bin/bash

set -o xtrace
set -o errexit

echo "************************************** Create dependency image ******************************************"

file='./ci/version'
VERSION_NUMBER=$(<"$file")

echo "Launch Create dependency image for $VERSION_NUMBER"

git clone --branch debug_tests_plugins --depth 1 https://github.com/cytomine/pims ./ci/app

mkdir -p ./ci/app/plugins/pims-plugin-format-openslide/
cp -r ./pims_plugin_format_openslide ./ci/app/plugins/pims-plugin-format-openslide/
cp -r ./tests ./ci/app/plugins/pims-plugin-format-openslide/
cp ./setup.py ./ci/app/plugins/pims-plugin-format-openslide/


docker build --rm -f scripts/docker/Dockerfile-dependencies -t  cytomine/pims-plugin-format-openslide-dependencies:v$VERSION_NUMBER .
