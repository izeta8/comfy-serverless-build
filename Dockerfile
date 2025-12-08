# 1. Usamos la imagen oficial de RunPod como base
FROM runpod/worker-comfyui:5.6.0-base

# 2. Instalamos librerías de sistema (necesarias para opencv, reactor, etc)
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalamos las librerías de Python para tus Nodos Custom
# He añadido las que daban error en tus logs:
# - insightface, onnxruntime-gpu (Para ReActor)
# - ultralytics, piexif, segment-anything (Para Impact Pack)
# - numba (Para WAS Node)
RUN pip install insightface onnxruntime-gpu segment-anything ultralytics piexif numba

# 4. Copiamos el mapa de rutas corregido al contenedor
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# El script de arranque original ya sabe qué hacer