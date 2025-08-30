#!/bin/bash

set -e

./create-cluster-maybe.sh
./configure-eks-auto-mode.sh
./apply-crds.sh
./install-argocd.sh
./install-apps.sh

pushd $HOME/work/external-repos/autoscaler/vertical-pod-autoscaler/hack
FEATURE_GATES="InPlaceOrRecreate=true" ./vpa-up.sh
popd || true

printf "To read the admin password for ArgoCD, run:\n"
echo "argocd admin initial-password -n argocd | head -n 1 | pbcopy"
