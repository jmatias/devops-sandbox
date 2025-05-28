#!/bin/bash

install_argocd() {

  kubectl create namespace argocd || true
  kubectl config set-context --current --namespace argocd

  kubectl apply -f "https://raw.githubusercontent.com/external-secrets/external-secrets/v0.16.1/deploy/crds/bundle.yaml"

  kubectl apply -n argocd -k ../apps/argocd/overlays/aws

  sleep 1
  kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
  argocd login --core

  argocd repo add git@github.com:jmatias/eks-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name eks-sandbox

  sleep 2
  kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
}

install_apps() {
  argocd login --core
  argocd app create app-of-apps \
    --upsert \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo git@github.com:jmatias/eks-sandbox.git \
    --path infra/apps/app-of-apps \
    --sync-policy automated \
    --revision main
}

set -e

install_argocd
install_apps
