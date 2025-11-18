#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Fetching endpoint for VLM Pod"

# Wait for publicIp to become available
for i in {1..40}; do
  VLM_ENDPOINT=$(curl -s -H "$AUTH_HEADER" "$API_URL/pods/$VLM_POD_ID" \
    | jq -r '.publicIp')

  if [[ "$VLM_ENDPOINT" != "null" && "$VLM_ENDPOINT" != "" ]]; then
    echo "VLM Pod Public IP is ready"
    echo "VLM_ENDPOINT=$VLM_ENDPOINT" >> "$GITHUB_ENV"
    exit 0
  fi

  echo "Public IP not ready yet... retrying in 10s"
  sleep 10
done

echo "ERROR: Timed out waiting for VLM Pod public IP."
exit 1
