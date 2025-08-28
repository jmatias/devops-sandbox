#!/usr/bin/env bash


kubectl config set-context --current --namespace argocd

kubectl apply -n argocd -k ../apps/argocd/overlays/aws

## Wait for the ArgoCD server to be ready
sleep 1
kubectl wait --timeout=60s --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
argocd login --core

./add-repos.sh

## In case the wait call above fails, try again
sleep 2
kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
