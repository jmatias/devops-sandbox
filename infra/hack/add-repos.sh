#!/usr/bin/env bash

set -e

argocd repo add git@github.com:jmatiascabrera/devops-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name devops-sandbox
argocd repo add git@github.com:jmatias/self-serve-example.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project default --name devops-sandbox

argocd repo add git@github.com:jmatiascabrera/devops-sandbox.git --ssh-private-key-path ~/.ssh/id_ed25519_personal --project github-actions --name devops-sandbox

set +e
