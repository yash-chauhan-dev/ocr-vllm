#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Deploying VLM Pod..."

VLM_RESPONSE=$(
  curl -s -X POST "$API_URL/pods" \
    -H "$AUTH_HEADER" \
    -H "Content-Type: application/json" \
    -d "{
      \"cloudType\": \"SECURE\",
      \"computeType\": \"GPU\",
      \"containerDiskInGb\": 30,
      \"containerRegistryAuthId\": \"$CONTAINER_REGISTRY_AUTH_ID\",
      \"gpuCount\": 1,
      \"gpuTypeIds\": [
        \"NVIDIA A40\"
      ],
      \"imageName\": \"ghcr.io/$GH_USERNAME/paddleocr-vlm-server:latest\",
      \"minRAMPerGPU\": 32,
      \"minVCPUPerGPU\": 9,
      \"name\": \"paddleocr-vlm-server\",
      \"ports\": [
        \"8080/http\",
        \"22/tcp\"
      ],
      \"vcpuCount\": 9,
      \"volumeInGb\": 50,
      \"volumeMountPath\": \"/workspace\"
    }"
)

echo "$VLM_RESPONSE" > .vlm_response.json

VLM_POD_ID=$(jq -r '.id' .vlm_response.json)

echo "VLM_POD_ID=$VLM_POD_ID"
echo "VLM_POD_ID=$VLM_POD_ID" >> "$GITHUB_ENV"
