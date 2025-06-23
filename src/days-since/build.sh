#!/usr/bin/env bash

VERSION=$1

set -e

docker buildx build --platform linux/amd64 --push \
  -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/days-since:latest \
  -t 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/days-since:"$VERSION" .

#docker pull 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/days-since:$VERSION

#docker push 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/days-since:"$VERSION"
#docker push 386757133934.dkr.ecr.us-east-1.amazonaws.com/javier/days-since:latest
