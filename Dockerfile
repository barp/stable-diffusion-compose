# Paperspace base container as our baseline
FROM ghcr.io/ai-dock/pytorch:2.0.1-py3.10-cuda-11.8.0-base-22.04

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# Upgrade pip to prevent install errors
RUN pip3 install --upgrade pip

# Clone Web UI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

# Make it working directory 
WORKDIR /stable-diffusion-webui

## pip installs
RUN pip install transformers scipy ftfy ipywidgets msgpack rich einops omegaconf pytorch_lightning basicsr optax facexlib realesrgan kornia imwatermark invisible-watermark piexif fonts font-roboto gradio
RUN pip install git+https://github.com/crowsonkb/k-diffusion.git
RUN pip install -e git+https://github.com/CompVis/taming-transformers.git@master#egg=taming-transformers
RUN pip install git+https://github.com/openai/CLIP.git
RUN pip install diffusers

# Finish setup
RUN pip install -r requirements.txt
RUN mkdir repositories
RUN git clone https://github.com/CompVis/stable-diffusion /stable-diffusion-webui/repositories/stable-diffusion
RUN git clone https://github.com/TencentARC/GFPGAN.git /stable-diffusion-webui/repositories/GFPGAN
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /stable-diffusion-webui/extensions/controlnet

EXPOSE 7860