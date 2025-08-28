#!/usr/bin/env bash

kubectl apply -f ../app-of-apps/templates/eks-auto/node-class.yaml
kubectl apply -f ../app-of-apps/templates/eks-auto/node-pool.yaml
kubectl apply -f ../app-of-apps/templates/eks-auto/ingress-class.yaml
kubectl apply -f ../app-of-apps/templates/eks-auto/storage-class.yaml

aws eks create-access-entry \
  --cluster-name javier-sandbox-eks \
  --principal-arn arn:aws:iam::386757133934:role/javier-sandbox-eks-cluster-AutoModeNodeRole \
  --type EC2 || echo "Access entry already exists, skipping."

aws eks associate-access-policy \
  --cluster-name javier-sandbox-eks \
  --principal-arn arn:aws:iam::386757133934:role/javier-sandbox-eks-cluster-AutoModeNodeRole \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSAutoNodePolicy \
  --access-scope type=cluster || echo "Access policy already associated, skipping."
