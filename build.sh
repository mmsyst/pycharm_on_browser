#!/bin/bash
cd `dirname $0`
set -euxo pipefail

REPOSITORY=pycharm-c
TAG=23.01.26
IS_GPU=1

TMP_NAME=$(docker image ls --format "{{.ID}}" --filter "reference=${REPOSITORY}:base")
if [ "${TMP_NAME}" = "" ]; then
  DOCKER_BUILDKIT=1 docker build --no-cache -t ${REPOSITORY}:base -f ./Dockerfile.base .
fi
if [ ${IS_GPU} -eq 1 ]; then
  DOCKER_BUILDKIT=1 docker build --no-cache -t ${REPOSITORY}:${TAG} -f ./Dockerfile.gpu .
else
  DOCKER_BUILDKIT=1 docker build --no-cache -t ${REPOSITORY}:${TAG} -f ./Dockerfile.cpu .
fi