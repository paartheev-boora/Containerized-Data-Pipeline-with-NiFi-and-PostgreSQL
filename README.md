# MediaPipe GPU Docker Setup

This Dockerfile builds MediaPipe with GPU support (CUDA) and launches real-time hand tracking from your webcam.

## 🚀 Build the Image

```bash
docker build -t mediapipe-gpu .
```

## 🎥 Run the Container

```bash
xhost +local:docker  # Allow Docker to access GUI (Linux only)

docker run --gpus all --rm -it \
    --device=/dev/video0:/dev/video0 \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    mediapipe-gpu
```

## ⚠️ Requirements

- NVIDIA GPU with drivers and Docker Toolkit
- X11 GUI setup to display OpenCV window
- Docker 20.10+

