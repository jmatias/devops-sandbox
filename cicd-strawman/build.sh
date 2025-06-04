#!/usr/bin/env bash

VERSION=$1

set -e

docker buildx build --platform linux/amd64 --push \
  -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/cicd-strawman:latest \
  -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/cicd-strawman:"$VERSION" .
