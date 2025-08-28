#!/usr/bin/env bash

kubectl create namespace argocd || true
argocd login --core
argocd app create app-of-apps \
  --upsert \
  --dest-namespace argocd \
  --dest-server https://kubernetes.default.svc \
  --repo git@github.com:jmatiascabrera/devops-sandbox.git \
  --path infra/app-of-apps \
  --sync-policy automated \
  --revision main
