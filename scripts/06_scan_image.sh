#!/usr/bin/env bash
set -euo pipefail

: "${REGISTRY_ID:?Set REGISTRY_ID}"

REPOSITORY="$REGISTRY_ID/demo-app"

mkdir -p evidence/before evidence/after

echo "[+] Images in repository"
yc container image list --repository-name="$REPOSITORY"

VULN_IMAGE_ID=$(yc container image list \
  --repository-name="$REPOSITORY" \
  --format json \
  | jq -r '.[] | select((.tags // []) | index("vulnerable")) | .id')

SECURE_IMAGE_ID=$(yc container image list \
  --repository-name="$REPOSITORY" \
  --format json \
  | jq -r '.[] | select((.tags // []) | index("secure")) | .id')

echo "[+] Vulnerable image ID: $VULN_IMAGE_ID"
echo "[+] Secure image ID: $SECURE_IMAGE_ID"

yc container image scan "$VULN_IMAGE_ID" --format json \
  | tee evidence/before/image-scan-before.json

VULN_SCAN_ID=$(jq -r .id evidence/before/image-scan-before.json)

yc container image list-vulnerabilities \
  --scan-result-id="$VULN_SCAN_ID" \
  --format json \
  | tee evidence/before/image-vulnerabilities-before.json

yc container image scan "$SECURE_IMAGE_ID" --format json \
  | tee evidence/after/image-scan-after.json

SECURE_SCAN_ID=$(jq -r .id evidence/after/image-scan-after.json)

yc container image list-vulnerabilities \
  --scan-result-id="$SECURE_SCAN_ID" \
  --format json \
  | tee evidence/after/image-vulnerabilities-after.json

echo "[+] Before summary"
jq -r 'group_by(.severity) | map({severity: .[0].severity, count: length}) | .[]' \
  evidence/before/image-vulnerabilities-before.json \
  | tee evidence/before/image-vulnerabilities-summary-before.txt || true

echo "[+] After summary"
jq -r 'group_by(.severity) | map({severity: .[0].severity, count: length}) | .[]' \
  evidence/after/image-vulnerabilities-after.json \
  | tee evidence/after/image-vulnerabilities-summary-after.txt || true
