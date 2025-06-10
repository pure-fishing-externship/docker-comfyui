# Dockerfile
# This is the blueprint that builds your application environment from scratch.

# Start from an official NVIDIA base image with CUDA drivers.
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set environment variables to prevent interactive pop-ups during the build.
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install essential system tools like Python, pip (Python's installer), and Git.
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container for all subsequent commands.
WORKDIR /app

# --- Step 1: Clone the main ComfyUI application ---
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# --- Step 2: Clone your required custom nodes ---
# This is where you add a line for each custom node you need.
# The code will be placed inside the container at ./custom_nodes/
RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git ./custom_nodes/comfyui_controlnet_aux && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git ./custom_nodes/ComfyUI_IPAdapter_plus && \
    git clone https://github.com/Acly/comfyui-inpaint-nodes.git ./custom_nodes/comfyui-inpaint-nodes && \
    git clone https://github.com/Acly/comfyui-tooling-nodes.git ./custom_nodes/comfyui-tooling-nodes


# --- Step 3: Install all Python dependencies ---
# This runs the slow pip install process. It will also install any requirements
# from the custom nodes you cloned above.
RUN pip3 install -r requirements.txt

# --- Step 4: Expose the port ---
# Tell Docker that the application inside this container will listen on port 8188.
EXPOSE 8188

# --- Step 5: Set the default run command ---
# This is the command that will execute when the container starts.
CMD [ "python3", "main.py", "--listen", "--port", "8188" ]