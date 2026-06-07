#!/usr/bin/env bash
set -euo pipefail

echo "[+] Tool versions"
git --version || true
terraform version || true
yc version || true
kubectl version --client=true || true
docker --version || true
jq --version || true

echo
echo "[+] Yandex Cloud profile"
yc config list || true

echo
echo "[+] Clouds"
yc resource-manager cloud list || true

echo
echo "[+] Folders"
yc resource-manager folder list || true
