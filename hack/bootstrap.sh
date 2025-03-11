#!/bin/bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 5
kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd

#kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
argocd login --core --insecure

argocd repo add git@github.com:jmatias/eks-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name eks-sandbox

ecr_password=$(aws ecr get-login-password --region us-east-1)

argocd app create app-of-apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo git@github.com:jmatias/eks-sandbox.git \
    --path apps/app-of-apps --revision main --sync-policy automated

sleep 5
argocd app wait backstage --timeout 300

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


kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server
kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-application-controller
sleep 5

kubectl wait --for=condition=Ready pod/"$(kubectl get pod -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')" -n argocd
