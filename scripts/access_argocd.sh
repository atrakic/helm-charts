#!/usr/bin/env bash
set -euo pipefail

NS=${NS:-argocd}
kubectl -n "$NS" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
kubectl port-forward -n "$NS" --address='0.0.0.0' service/argocd-server 8080:80 &

echo "https://localhost:8080"
