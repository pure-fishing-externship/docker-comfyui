# Use an official NVIDIA CUDA base image
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Set the working directory inside the container
WORKDIR /app

# Prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install Python, pip, git, and other essentials
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3-pip \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Clone the main ComfyUI application
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Install base Python dependencies from the main requirements file
RUN python3.11 -m pip install --no-cache-dir -r ComfyUI/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121

# --- Add and configure the startup script ---
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
# --- End of script configuration ---

# Install additional Python dependencies for ComfyUI
RUN python3.11 -m pip install opencv-python-headless matplotlib scikit-image


# Expose the ComfyUI port
EXPOSE 8188

# Set the script as the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

# Set the default command for the entrypoint script
# These arguments will be passed to the script's "exec $@" line
CMD ["python3.11", "ComfyUI/main.py", "--listen", "0.0.0.0", "--highvram", "--bf16-vae", "--pytorch-compile"]