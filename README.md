# ComfyUI Docker Deployment for GPU Instances

This repository contains the necessary configuration files to quickly deploy and run ComfyUI on a GPU-enabled cloud instance (or a local machine with an NVIDIA GPU). It leverages Docker for consistent environments and Google Cloud Storage (GCS) for persistent data.

## Features

* **Pre-built Docker Image:** Utilizes a public Docker image (`beat2319/comfyui:latest`) for rapid deployment, avoiding lengthy build times.
* **Cloud Data Sync:** Integrates with Google Cloud Storage to manage models, custom nodes, and workflows separately from the compute instance.
* **Docker Compose:** Simplifies the setup and management of the ComfyUI container.
* **GPU Accelerated:** Configured to leverage NVIDIA GPUs via the NVIDIA Container Toolkit.

---

## Prerequisites (On your GPU Instance)

Before starting, ensure your GPU instance (or local machine) has the following software installed:

* **NVIDIA Drivers:** Your GPU provider should have these pre-installed.
* **Docker Engine:** [Installation Guide](https://docs.docker.com/engine/install/)
* **Docker Compose:** [Installation Guide](https://docs.docker.com/compose/install/)
* **NVIDIA Container Toolkit:** Essential for Docker containers to access your GPU. [Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
* **Google Cloud CLI (`gcloud CLI`):** The command-line tool for Google Cloud. You'll also need appropriate authentication configured to access your GCS bucket.
    * [gcloud CLI Installation](https://cloud.google.com/sdk/docs/install)
    * [Authenticating for `gsutil`](https://cloud.google.com/storage/docs/gsutil/commands/gsutil#authentication) (usually `gcloud auth login` and `gcloud config set project <YOUR_PROJECT_ID>`)

---

## Deployment Workflow

Follow these steps each time you set up a new GPU instance or refresh your ComfyUI environment:

### Step 1: Clone This Repository

Start by cloning this repository to get your `docker-compose.yml` and other orchestration files onto your instance.

```bash
git clone https://github.com/pure-fishing-externship/docker-comfyui.git

