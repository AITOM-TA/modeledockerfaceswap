FROM runpod/worker-comfyui:5.5.1-base

# -------- Custom nodes nécessaires --------
# Chargement LoRA depuis une URL
RUN comfy node install --exit-on-fail https://github.com/a-und-b/ComfyUI_LoRA_from_URL.git

# Nodes réseau / HTTP (pour requêtes API, URL, etc. – via Impact Pack)
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.1

# TBG SAM3 (Selector + Segmentation, pour SAM3 point prompts)
RUN comfy node install --exit-on-fail https://github.com/Ltamann/ComfyUI-TBG-SAM3.git

# (Optionnel) ComfyUI-SAM3 “vanilla” si tu veux aussi l’utiliser
RUN comfy node install --exit-on-fail https://github.com/PozzettiAndrea/ComfyUI-SAM3.git

# -------- Modèles utilisés par ton workflow Flux2 Face Swap --------

# Flux2 Klein 9B UNet
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/flux2-klein-9b/resolve/main/flux-2-klein-9b.safetensors \
  --relative-path models/diffusion_models \
  --filename flux-2-klein-9b.safetensors

# Flux2 VAE
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors \
  --relative-path models/vae \
  --filename flux2-vae.safetensors

# Qwen 3 8B (texte pour Flux2)
RUN comfy model download \
  --url https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/text_encoders/qwen_3_8b_fp8mixed.safetensors \
  --relative-path models/text_encoders \
  --filename qwen_3_8b_fp8mixed.safetensors

# LoRA head swap utilisée par LoraLoaderModelOnly
RUN comfy model download \
  --url https://huggingface.co/ton-org/bfs_head_flux_klein9b/resolve/main/bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors \
  --relative-path models/loras \
  --filename bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors
