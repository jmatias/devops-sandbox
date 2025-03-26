#!/usr/bin/env bash

VERSION=$1

set -x
#yarn tsc
#yarn build:all

docker build --platform linux/amd64 -t 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest -t 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" . &&
  docker push 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" &&
  docker push 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest
