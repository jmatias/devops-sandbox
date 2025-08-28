#!/usr/bin/env bash
# if eks cluster does not exist, create it

if ! ./check-if-eks-cluster-exists.sh javier-sandbox-eks; then
  pushd ../cluster || exit
  echo "Cluster does not exist, creating it..."
  eksctl create cluster -f cluster.yaml
  popd || exit
else
  echo "Cluster exists, skipping creation."
fi
