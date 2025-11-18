#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Waiting for VLM Pod"

for i in {1..40}; do
  STATUS=$(curl -s -H "$AUTH_HEADER" "$API_URL/pods/$VLM_POD_ID" | jq -r '.desiredStatus')
  echo "Status: $STATUS"

  if [ "$STATUS" = "RUNNING" ]; then
    echo "Pod is now RUNNING"
    exit 0
  fi

  sleep 15
done

echo "Timeout waiting for pod."
exit 1
