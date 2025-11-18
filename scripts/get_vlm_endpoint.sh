#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Fetching endpoint for VLM Pod: $VLM_POD_ID"

VLM_ENDPOINT=$(curl -s -H "$AUTH_HEADER" "$API_URL/pods/$VLM_POD_ID" | jq -r '.publicIp')

echo "VLM_ENDPOINT=$VLM_ENDPOINT"
echo "VLM_ENDPOINT=$VLM_ENDPOINT" >> "$GITHUB_ENV"
