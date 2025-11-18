#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Deploying Pipeline Pod..."

PIPELINE_RESPONSE=$(
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
      \"imageName\": \"ghcr.io/$GH_USERNAME/paddleocr-vl-api:latest\",
      \"minRAMPerGPU\": 32,
      \"minVCPUPerGPU\": 9,
      \"name\": \"paddleocr-vl-api\",
      \"ports\": [
        \"8080/http\",
        \"22/tcp\"
      ],
      \"env\": [
        {\"key\": \"GENAI_SERVER_URL\", \"value\": \"$VLM_ENDPOINT\"},
        {\"key\": \"BUILD_FOR_OFFLINE\", \"value\": \"true\"}
      ],
      \"vcpuCount\": 9,
      \"volumeInGb\": 50,
      \"volumeMountPath\": \"/workspace\"
    }"
)