#!/usr/bin/env bash
# check-eks-cluster.sh
# Usage: ./check-eks-cluster.sh <cluster-name> [region]

set -euo pipefail

CLUSTER_NAME="${1:-}"
REGION="${2:-us-east-1}"

if [[ -z "$CLUSTER_NAME" ]]; then
  echo "Usage: $0 <cluster-name> [region]" >&2
  exit 1
fi

if aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$REGION" \
  --query 'cluster.status' \
  --output text >/dev/null 2>&1; then
  STATUS=$(aws eks describe-cluster \
    --name "$CLUSTER_NAME" \
    --region "$REGION" \
    --query 'cluster.status' \
    --output text)
  echo "Cluster '$CLUSTER_NAME' exists in region '$REGION' (status: $STATUS)"
  exit 0
else
  echo "Cluster '$CLUSTER_NAME' does NOT exist in region '$REGION'"
  exit 1
fi
