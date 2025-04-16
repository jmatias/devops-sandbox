#!/usr/bin/env bash

VERSION=$1

set -x
#yarn tsc
#yarn build:all

docker build --platform linux/amd64 -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" . &&
  docker push 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" &&
  docker push 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest
