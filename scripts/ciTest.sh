#!/bin/bash

set -o xtrace
set -o errexit

echo "************************************** Launch tests ******************************************"

file='./ci/version'
VERSION_NUMBER=$(<"$file")

echo "Launch tests for $VERSION_NUMBER"
mkdir "$PWD"/ci/test-reports
touch "$PWD"/ci/test-reports/pytest_unit.xml
docker build --rm -f scripts/docker/Dockerfile-test --build-arg VERSION_NUMBER=$VERSION_NUMBER -t  cytomine/pims-plugin-format-openslide-test .

containerId=$(docker create -v "$PWD"/ci/test-reports:/app/ci/test-reports -v /data/pims:/data/pims cytomine/pims-plugin-format-openslide-test )

docker start -ai  $containerId
docker rm $containerId
