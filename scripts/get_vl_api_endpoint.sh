#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Fetching endpoint for VL API Pod"

# Wait for publicIp to become available
for i in {1..40}; do

  VL_API_ENDPOINT=$(curl -s -H "$AUTH_HEADER" "$API_URL/pods/$VL_API_POD_ID" \
    | jq -r '.publicIp')

  if [[ "$VL_API_ENDPOINT" != "null" && "$VL_API_ENDPOINT" != "" ]]; then
    echo "VL API Pod is ready"
    echo "VL_API_ENDPOINT=$VL_API_ENDPOINT" >> "$GITHUB_ENV"
    exit 0
  fi

  echo "Deployment in process..."
  sleep 10
done

echo "ERROR: Timed out waiting for VLM Pod."
exit 1
