#!/usr/bin/env bash
echo "Checking HTTP health endpoint..."
for i in {1..20}; do
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://$VL_API_ENDPOINT:8080/health")

  echo "Health Check Response: $STATUS_CODE"

  if [ "$STATUS_CODE" = "200" ]; then
    echo "VL API Server is HEALTHY!"
    exit 0
  fi

  sleep 5
done

echo "ERROR: VL API Server health check failed."
exit 1