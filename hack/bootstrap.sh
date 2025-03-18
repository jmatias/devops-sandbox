#!/bin/bash

install_argocd() {

  set -e
  kubectl create namespace argocd
  kubectl config set-context --current --namespace argocd

  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.12.10/manifests/install.yaml
  sleep 1
  kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
  argocd login --core --insecure

  argocd repo add git@github.com:jmatias/eks-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name eks-sandbox

  sleep 2
  kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
}

add_ecr_repos() {
  local ecr_password
  ecr_password=$(aws ecr get-login-password --region us-east-1 --profile tw)
  kubectl -n celery-sandbox create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password"
  kubectl -n argocd create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password"
  kubectl -n backstage create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password"
}

install_apps() {
  argocd login --core --insecure
  argocd app create app-of-apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo git@github.com:jmatias/eks-sandbox.git \
    --path apps/app-of-apps \
    --revision local \
    --sync-policy automated

  postgres_password="$(diceware -n 5 -s 1)"
  kubectl create namespace backstage
  # create secret for backstage postgres
  kubectl -n backstage create secret generic postgres-secrets \
    --from-literal=POSTGRES_USER=backstage \
    --from-literal=POSTGRES_PASSWORD="$postgres_password" \
    --from-literal=password="$postgres_password"

  sleep 2
  argocd app wait backstage --timeout 300

  argocd app sync app-of-apps argocd
}

set -e

#install_argocd
install_apps
add_ecr_repos
