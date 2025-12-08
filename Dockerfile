
# 1. Usamos la imagen oficial de RunPod como base
FROM runpod/worker-comfyui:5.6.0-base

# 2. Instalamos las librerías de sistema que faltan para tus nodos (Reactor, etc.)
# Esto evita que falle al arrancar
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalamos las librerías de Python necesarias para tus Nodos Custom
# (Si usas Reactor, FaceDetailer, etc, esto es OBLIGATORIO)
RUN pip install insightface onnxruntime-gpu segment-anything

# 4. Copiamos tu mapa de rutas al lugar donde el worker lo buscará
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# Listo. No tocamos el comando de arranque, usamos el original.