#!/bin/bash

# Flux + Civitai Models Setup Script
# Usage: ./setup_flux.sh YOUR_CIVITAI_API_KEY

set -e  # Exit on error

# Check if API key is provided
if [ -z "$1" ]; then
    echo "Error: Civitai API key required"
    echo "Usage: ./setup_flux.sh YOUR_CIVITAI_API_KEY"
    exit 1
fi

CIVITAI_API_KEY="$1"

echo "=========================================="
echo "Flux Models Setup"
echo "=========================================="

# Download Flux Text Encoders
echo ""
echo "Downloading Flux text encoders..."
wget -c -O ComfyUI/models/text_encoders/clip_l.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"

wget -c -O ComfyUI/models/text_encoders/t5xxl_fp16.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"

# Download Flux VAE
echo ""
echo "Downloading Flux VAE..."
wget -c -O ComfyUI/models/vae/ae.safetensors \
    "https://huggingface.co/Comfy-Org/Lumina_Image_2.0_Repackaged/resolve/main/split_files/vae/ae.safetensors"

# Download Civitai models
echo ""
echo "Downloading models from Civitai..."
curl -L -H "Authorization: Bearer $CIVITAI_API_KEY" \
    -o ComfyUI/models/loras/handwriting_lora.safetensors \
    "https://civitai.com/api/download/models/1358960?type=Model&format=SafeTensor"

curl -L -H "Authorization: Bearer $CIVITAI_API_KEY" \
    -o ComfyUI/models/checkpoints/flux_checkpoint_bf16.safetensors \
    "https://civitai.com/api/download/models/1319700?type=Model&format=SafeTensor&size=full&fp=bf16"
# Download workflow
echo ""
echo "Downloading workflow..."
wget -c -O ComfyUI/user/default/workflows/flux_text.json \
    "https://raw.githubusercontent.com/kirillkoks999-oss/comfy-run/main/flux_text.json"

echo ""
echo "=========================================="
echo "✓ All models downloaded successfully!"
echo "=========================================="
echo ""
echo "Models location:"
echo "  Text Encoders: ComfyUI/models/text_encoders/"
echo "  VAE: ComfyUI/models/vae/"
echo "  Diffusion Model: ComfyUI/models/diffusion_models/"
echo "  LoRA: ComfyUI/models/loras/"
echo "  Checkpoint: ComfyUI/models/checkpoints/"
echo ""
