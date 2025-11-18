# OCR-vLLM Deployment

This repository contains an automated pipeline for building, containerizing, and deploying an OCR-vLLM inference service using **GitHub Actions**, **Docker**, and **RunPod**.  
It is not a software implementation of OCR or vLLM itself—instead, it provides the infrastructure and automation required to reliably deploy the model as an inference endpoint.


## Overview

The goal of this repository is to automate:

1. **Building Docker images** for the OCR-vLLM model  
2. **Pushing the images** to GitHub Container Registry (GHCR)  
3. **Deploying the container** to RunPod serverless pods for inference  
4. **Exposing an API endpoint** that can be used to query the model

This setup enables fully automated CI/CD for model serving.

## How It Works

### 1. Docker-Based Build System
The repository contains Dockerfiles defining how the OCR-vLLM inference environment is constructed.  
The build workflow:

- Runs automatically on push or PR  
- Builds Docker images using the included Dockerfiles  
- Pushes the images to **GitGitHub Container Registry (GHCR)**

### 2. Automated Deployment to RunPod
A second GitHub Actions workflow:

- Pulls the GHCR container image  
- Deploys it to **RunPod Serverless / GPU Pods**  
- Starts the inference container  
- Retrieves the **public API endpoint** after deployment

### 3. End-to-End DevOps Pipeline
Once configured:

Commit → Build → Push → Deploy → Accessible Inference Endpoint

## Inference Endpoint

After deployment, RunPod provides an HTTP endpoint for interacting with the inference server.

Example request:

```bash
POST https://<runpod-endpoint>/layout-parsing
{
  "file": "https://path/to/image.jpg"
}
```

## Tech Stack

- **Docker** – Containerization  
- **GitHub Actions** – CI/CD automation  
- **GitHub Container Registry (GHCR)** – Container storage  
- **RunPod** – GPU-accelerated inference hosting  
- **vLLM** – High-throughput LLM serving (inside container)  

## Notes

- This is a **DevOps automation project**, not a model implementation.  
- Required repo secrets:
  - `GHCR_TOKEN`
  - `RUNPOD_API_KEY`
  - Pod or cluster configuration values
- Workflows can be extended for multi-model or multi-environment deployment.

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.
