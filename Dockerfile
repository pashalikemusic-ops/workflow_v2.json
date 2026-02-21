FROM runpod/worker-comfyui:5.5.1-base

# ── Custom Nodes ────────────────────────────────────────
# IPAdapter for Flux (face consistency)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux.git

# ── Models ──────────────────────────────────────────────
# Flux Dev fp8 checkpoint (~12GB)
RUN wget -q --show-progress -O /comfyui/models/checkpoints/flux1-dev-fp8.safetensors \
    "https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8.safetensors"

# IPAdapter model for Flux
RUN mkdir -p /comfyui/models/ipadapter && \
    wget -q --show-progress -O /comfyui/models/ipadapter/ip-adapter.bin \
    "https://huggingface.co/InstantX/FLUX.1-dev-IP-Adapter/resolve/main/ip-adapter.bin"

# CLIP Vision (SigLIP - required for IPAdapter)
RUN wget -q --show-progress -O /comfyui/models/clip_vision/sigclip_vision_patch14_384.safetensors \
    "https://huggingface.co/Comfy-Org/sigclip_vision_384/resolve/main/sigclip_vision_patch14_384.safetensors"

# 4x-UltraSharp upscaler
RUN wget -q --show-progress -O /comfyui/models/upscale_models/4x-UltraSharp.pth \
    "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth"

# Realism LoRA (skin texture)
RUN wget -q --show-progress -O /comfyui/models/loras/photorealistic_skin_flux_v2.safetensors \
    "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors"
