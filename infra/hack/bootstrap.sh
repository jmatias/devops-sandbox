#!/bin/bash

install_argocd() {

  set -e
  set -x
  kubectl create namespace argocd || true
  kubectl config set-context --current --namespace argocd

  #  kubectl -n argocd create secret generic argocd-secret \
  #    --from-literal=admin.password="$ARGOCD_PASSWORD" || true

  kubectl -n argocd apply -f ../apps/argocd/overlays/local/argocd-cmd-params-cm.yaml

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

  kubectl delete secret ecr-registry-secret -n celery-sandbox || true
  kubectl delete secret ecr-registry-secret -n argocd || true
  kubectl delete secret ecr-registry-secret -n backstage || true

  kubectl -n celery-sandbox create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n argocd create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
  kubectl -n backstage create secret docker-registry ecr-registry-secret \
    --docker-server=590184073526.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$ecr_password" || true
}

install_apps() {
  argocd login --core --insecure
  argocd app create app-of-apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo git@github.com:jmatias/eks-sandbox.git \
    --path infra/apps/app-of-apps \
    --revision starting-over \
    --sync-policy automated

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

  sleep 2
  argocd app wait backstage --timeout 300

  argocd app sync app-of-apps argocd
}

set -e

install_argocd
install_apps
add_ecr_repos
