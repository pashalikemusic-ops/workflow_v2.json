FROM runpod/worker-comfyui:5.5.1-base

# Custom nodes
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux.git && \
    git clone https://github.com/Acly/comfyui-tooling-nodes.git

# FLUX UNet (fp8)
RUN mkdir -p /comfyui/models/diffusion_models && \
    wget -q --show-progress -O /comfyui/models/diffusion_models/flux1-dev-fp8.safetensors \
    "https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-dev-fp8.safetensors"

# CLIP-L + T5 XXL (для DualCLIPLoader)
RUN mkdir -p /comfyui/models/clip && \
    wget -q --show-progress -O /comfyui/models/clip/clip_l.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors" && \
    wget -q --show-progress -O /comfyui/models/clip/t5xxl_fp8_e4m3fn.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"

# FLUX VAE (mirror — original is gated on black-forest-labs)
RUN mkdir -p /comfyui/models/vae && \
    wget -q --show-progress -O /comfyui/models/vae/ae.safetensors \
    "https://huggingface.co/cocktailpeanut/xulf-dev/resolve/main/ae.safetensors"

# IPAdapter model + CLIP Vision
RUN mkdir -p /comfyui/models/ipadapter && \
    wget -q --show-progress -O /comfyui/models/ipadapter/ip-adapter.bin \
    "https://huggingface.co/InstantX/FLUX.1-dev-IP-Adapter/resolve/main/ip-adapter.bin"

RUN wget -q --show-progress -O /comfyui/models/clip_vision/sigclip_vision_patch14_384.safetensors \
    "https://huggingface.co/Comfy-Org/sigclip_vision_384/resolve/main/sigclip_vision_patch14_384.safetensors"

# 4x-UltraSharp upscaler
RUN wget -q --show-progress -O /comfyui/models/upscale_models/4x-UltraSharp.pth \
    "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth"

# Skin LoRA
RUN wget -q --show-progress -O /comfyui/models/loras/photorealistic_skin_flux_v2.safetensors \
    "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors"
