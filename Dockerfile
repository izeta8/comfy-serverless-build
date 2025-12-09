# 1. Usamos la imagen oficial de RunPod como base
FROM runpod/worker-comfyui:5.6.0-base

# 2. Instalamos librerías de sistema
# AÑADIDO: build-essential y python3-dev para poder compilar insightface
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalamos las librerías de Python (CORREGIDO CON VERSIONES FIJAS)
# Ahora insightface podrá compilarse porque ya tenemos g++ instalado arriba.
RUN pip install insightface==0.7.3 onnxruntime-gpu segment-anything ultralytics piexif numba dynamicprompts dill

# 4. Copiamos tu mapa de rutas
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml