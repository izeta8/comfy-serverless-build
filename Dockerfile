# 1. Usamos la imagen oficial de RunPod como base
FROM runpod/worker-comfyui:5.6.0-base

# 2. Instalamos librerías de sistema
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalamos las librerías de Python para tus Nodos Custom
# HE AÑADIDO: dynamicprompts, dill, ultralytics (que faltaban en los logs)
RUN pip install insightface onnxruntime-gpu segment-anything ultralytics piexif numba dynamicprompts dill

# 4. Copiamos tu mapa de rutas al contenedor
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# Listo