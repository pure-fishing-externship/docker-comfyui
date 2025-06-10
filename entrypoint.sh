#!/bin/bash
# This script will be executed when the container starts

# Exit immediately if a command exits with a non-zero status.
set -e

# Find all requirements.txt files within the custom_nodes directory
# (looking 2 levels deep) and install them.
echo "Checking for custom node requirements..."
find /app/ComfyUI/custom_nodes -maxdepth 2 -name "requirements.txt" | while read reqs; do
    echo "Installing requirements from $reqs"
    pip install --no-cache-dir -r "$reqs"
done

# Now, execute the command passed to this script (the Dockerfile's CMD)
echo "Starting ComfyUI..."
exec "$@"