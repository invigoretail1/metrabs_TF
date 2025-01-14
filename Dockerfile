# # Use a base image with conda installed
# FROM continuumio/miniconda3:latest

# # Copy the environment.yml file to the container
# COPY environment1.yml /tmp/environment1.yml

# # Install system dependencies for Python packages
# RUN apt-get update && apt-get install -y build-essential libgl1-mesa-dev

# # Install system dependencies for Python packages and Qt
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libgl1-mesa-dev \
#     libxcb-xinerama0 \
#     libxcb-xinput0 \
#     libxcb-xfixes0 \
#     libxcb-randr0 \
#     libxcb-shape0 \
#     libxcb-render0 \
#     libxcb-shm0 \
#     libxcb-xkb1 \
#     libxkbcommon-x11-0 \
#     libxkbcommon0 \
#     qtbase5-dev \
#     qttools5-dev-tools \
#     libqt5x11extras5 \
#     libxcb-util1

# #For display    
# RUN apt-get update && apt-get install -y x11-apps

# # Solving Libinfo
# RUN apt-get update && apt-get install -y libncurses6 libtinfo6

# # Create the conda environment
# RUN conda env create -f /tmp/environment1.yml && conda clean -afy

# # Activate the environment and manually install rlemasklib
# RUN /opt/conda/envs/metrabs_env3/bin/pip install git+https://github.com/isarandi/rlemasklib.git

# # Set the default environment's PATH for non-interactive use
# ENV PATH="/opt/conda/envs/metrabs_env3/bin:$PATH"

# # Set the LD_LIBRARY_PATH environment variable
# ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda-11.8/lib64:/root/.local/lib/python3.9/site-packages/nvidia/cudnn/lib:/opt/conda/envs/metrabs_env3/lib:/opt/conda/envs/metrabs_env3/lib/python3.9/site-packages/tensorflow:/opt/conda/envs/metrabs_env3/lib/python3.9/site-packages/tensorflow_io/python/ops:/usr/lib/x86_64-linux-gnu"

# # Add the Qt platform plugin path
# ENV QT_QPA_PLATFORM_PLUGIN_PATH="/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms"

# # Set the working directory
# WORKDIR /app

# # Copy your code into the container (if needed)
# COPY . /app

# # Specify the default command
# CMD ["/bin/bash"]

# Use a base image with CUDA 11.8 and cuDNN 8
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Install Miniconda
RUN apt-get update && apt-get install -y wget && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    /opt/conda/bin/conda init bash
ENV PATH="/opt/conda/bin:$PATH"

# Install system dependencies for Python packages and Qt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-dev \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    libxcb-xfixes0 \
    libxcb-randr0 \
    libxcb-shape0 \
    libxcb-render0 \
    libxcb-shm0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    qtbase5-dev \
    qttools5-dev-tools \
    libqt5x11extras5 \
    libxcb-util1 \
    x11-apps \
    libncurses6 \
    libtinfo6 \
    git

# Reset the DEBIAN_FRONTEND to its default value
ENV DEBIAN_FRONTEND=

# Copy the environment.yml file to the container
COPY environment1.yml /tmp/environment1.yml

# Create the conda environment
RUN conda env create -f /tmp/environment1.yml && \
    conda clean -afy && \
    rm -rf /root/.cache/pip


# Activate the environment and manually install rlemasklib
RUN /opt/conda/envs/metrabs_env3/bin/pip install git+https://github.com/isarandi/rlemasklib.git

# Set the default environment's PATH for non-interactive use
ENV PATH="/opt/conda/envs/metrabs_env3/bin:$PATH"

# Set the LD_LIBRARY_PATH environment variable
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda-11.8/lib64:/root/.local/lib/python3.9/site-packages/nvidia/cudnn/lib:/opt/conda/envs/metrabs_env3/lib:/opt/conda/envs/metrabs_env3/lib/python3.9/site-packages/tensorflow:/opt/conda/envs/metrabs_env3/lib/python3.9/site-packages/tensorflow_io/python/ops:/usr/lib/x86_64-linux-gnu"

# Add the Qt platform plugin path
ENV QT_QPA_PLATFORM_PLUGIN_PATH="/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms"

# Set the XDG runtime directory to prevent warnings
ENV XDG_RUNTIME_DIR="/tmp/runtime-root"
RUN mkdir -p /tmp/runtime-root && chmod 700 /tmp/runtime-root

# Set the HOME environment variable
ENV HOME="/root"

# Set the working directory
WORKDIR /app

# Copy your project code into the container
COPY . /app

# Specify the default command
CMD ["/bin/bash"]

