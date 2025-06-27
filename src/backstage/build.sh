#!/usr/bin/env bash

VERSION=$1

set -e
set -x
yarn tsc
yarn build:all

docker buildx build --platform linux/amd64 --push -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" .
