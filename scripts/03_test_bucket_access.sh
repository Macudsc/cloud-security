#!/usr/bin/env bash
set -euo pipefail

: "${PUBLIC_BUCKET:?Set PUBLIC_BUCKET}"
: "${SECURE_BUCKET:?Set SECURE_BUCKET}"

mkdir -p evidence/before evidence/after

echo "[+] Testing public bucket access"
curl -i "https://storage.yandexcloud.net/${PUBLIC_BUCKET}/demo-report.txt" \
  | tee evidence/before/public-bucket-curl-before.txt

echo
echo "[+] Testing secure bucket anonymous access"
curl -i "https://storage.yandexcloud.net/${SECURE_BUCKET}/demo-report.txt" \
  | tee evidence/after/secure-bucket-curl-after.txt
