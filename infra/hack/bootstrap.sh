#!/bin/bash

install_argocd() {

  kubectl create namespace argocd || true
  kubectl config set-context --current --namespace argocd

  kubectl apply -f "https://raw.githubusercontent.com/external-secrets/external-secrets/v0.16.2/deploy/crds/bundle.yaml"


  kubectl apply -n argocd -k ../apps/argocd/overlays/aws

  sleep 1
  kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
  argocd login --core

  argocd repo add git@github.com:jmatiascabrera/devops-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name devops-sandbox

  sleep 2
  kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
}

install_apps() {

  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusagents.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_scrapeconfigs.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
  kubectl apply --server-side -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.82.0/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml

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

install_argocd
install_apps

pushd $HOME/work/external-repos/autoscaler/vertical-pod-autoscaler/hack
./vpa-up.sh
pod || true
