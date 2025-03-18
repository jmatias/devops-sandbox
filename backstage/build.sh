#!/usr/bin/env bash

VERSION=$1

docker build --platform linux/amd64 -f packages/backend/Dockerfile -t 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest \
  -t 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" . &&
  docker push 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:"$VERSION" &&
  docker push 590184073526.dkr.ecr.us-east-1.amazonaws.com/javier/backstage:latest
