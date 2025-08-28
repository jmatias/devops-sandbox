#!/bin/bash


install_argocd() {

  kubectl create namespace argocd || true
  kubectl config set-context --current --namespace argocd

  kubectl apply -n argocd -k ../apps/argocd/overlays/aws

  sleep 1
  kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
  argocd login --core

  ./add-repos.sh

  sleep 2
  kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
}

install_apps() {

  ./apply-crds.sh

  argocd login --core
  argocd app create app-of-apps \
    --upsert \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo git@github.com:jmatiascabrera/devops-sandbox.git \
    --path infra/app-of-apps \
    --sync-policy automated \
    --revision main
}

set -e

# if eks cluster does not exist, create it
if ! ./check-if-eks-cluster-exists.sh javier-sandbox-eks; then
  pushd ../cluster
  echo "Cluster does not exist, creating it..."
  eksctl create cluster -f cluster.yaml
  popd
else
  echo "Cluster exists, skipping creation."
fi

kubectl apply -f ../app-of-apps/templates/eks-auto/node-pool.yaml
kubectl apply -f ../app-of-apps/templates/eks-auto/ingress-class.yaml
kubectl apply -f ../app-of-apps/templates/eks-auto/storage-class.yaml


install_argocd
install_apps

#pushd $HOME/work/external-repos/autoscaler/vertical-pod-autoscaler/hack
#FEATURE_GATES="InPlaceOrRecreate=true" ./vpa-up.sh
#popd || true
