#!/bin/bash

install_argocd() {

  kubectl create namespace argocd || true
  kubectl config set-context --current --namespace argocd

  kubectl apply -n argocd -k ../apps/argocd/overlays/aws

  sleep 1
  kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
  argocd login --core

  argocd repo add git@github.com:jmatias/eks-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name eks-sandbox

  sleep 2
  kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
}

add_ecr_repos() {
  local ecr_password
  ecr_password=$(aws ecr get-login-password --region us-east-1 --profile tw-abbvie)

  kubectl create namespace backstage || true
  kubectl create namespace celery-sandbox || true
  kubectl create namespace argocd || true
  kubectl create namespace cert-manager || true

  kubectl delete secret ecr-registry-secret -n celery-sandbox || true
  kubectl delete secret ecr-registry-secret -n argocd || true
  kubectl delete secret ecr-registry-secret -n backstage || true
  kubectl delete secret ecr-registry-secret -n cert-manager || true

  kubectl -n celery-sandbox create secret docker-registry ecr-registry-secret \
    --docker-server=386757133934.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n argocd create secret docker-registry ecr-registry-secret \
    --docker-server=386757133934.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n backstage create secret docker-registry ecr-registry-secret \
    --docker-server=386757133934.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n cert-manager create secret docker-registry ecr-registry-secret \
    --docker-server=386757133934.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n sdlc-trace create secret docker-registry ecr-registry-secret \
    --docker-server=386757133934.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
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

  kubectl create namespace backstage || true

  # create secret for backstage postgres
  kubectl -n backstage create secret generic postgres-secrets \
    --from-literal=POSTGRES_USER="$POSTGRES_USER" \
    --from-literal=POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
    --from-literal=password="$POSTGRES_PASSWORD" || true

  kubectl -n backstage create secret generic backstage-secrets \
    --from-literal=AUTH_GITHUB_CLIENT_ID="$AUTH_GITHUB_CLIENT_ID" \
    --from-literal=AUTH_GITHUB_CLIENT_SECRET="$AUTH_GITHUB_CLIENT_SECRET" \
    --from-literal=AUTH_GITHUB_TEST_CLIENT_ID="$AUTH_GITHUB_TEST_CLIENT_ID" \
    --from-literal=AUTH_GITHUB_TEST_CLIENT_SECRET="$AUTH_GITHUB_TEST_CLIENT_SECRET" || true

  kubectl -n backstage create secret generic github-auth \
    --from-literal=AUTH_GITHUB_CLIENT_ID="$AUTH_GITHUB_CLIENT_ID" \
    --from-literal=AUTH_GITHUB_CLIENT_SECRET="$AUTH_GITHUB_CLIENT_SECRET" \
    --from-literal=AUTH_GITHUB_TEST_CLIENT_ID="$AUTH_GITHUB_TEST_CLIENT_ID" \
    --from-literal=AUTH_GITHUB_TEST_CLIENT_SECRET="$AUTH_GITHUB_TEST_CLIENT_SECRET" \
    --from-literal=GITHUB_TOKEN="$GITHUB_TOKEN" || true
}

set -e
#set -x

aws ecr get-login-password | docker login -u AWS --password-stdin "386757133934.dkr.ecr.us-east-1.amazonaws.com"

install_argocd
add_ecr_repos
install_apps
