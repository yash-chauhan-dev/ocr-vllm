#!/usr/bin/env bash
set -e
source scripts/common.sh

echo "Deploying VL API Pod..."

VL_API_RESPONSE=$(
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
      \"env\": {
        \"GENAI_SERVER_URL\": \"https://$VLM_POD_ID-8080.proxy.runpod.net/v1\",
        \"BUILD_FOR_OFFLINE\": \"true\"
      },
      \"vcpuCount\": 9,
      \"volumeInGb\": 50,
      \"volumeMountPath\": \"/workspace\"
    }"
)

echo "$VL_API_RESPONSE" > .vl_api_response.json

VL_API_POD_ID=$(jq -r '.id' .vl_api_response.json)

echo "::add-mask::$VL_API_POD_ID"
echo "VL_API_POD_ID=$VL_API_POD_ID" >> "$GITHUB_ENV"
