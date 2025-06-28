FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y     build-essential     cmake     git     curl     unzip     zip     pkg-config     python3-dev     python3-pip     python3-opencv     libopencv-dev     libgl1-mesa-glx     libgtk2.0-dev     ffmpeg     && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install numpy absl-py protobuf opencv-python matplotlib

RUN curl -Lo /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v1.17.0/bazelisk-linux-amd64 &&     chmod +x /usr/local/bin/bazel

WORKDIR /mediapipe
RUN git clone https://github.com/google/mediapipe.git .
RUN git checkout main

RUN bazel build -c opt --config=cuda     mediapipe/examples/desktop/hand_tracking:hand_tracking_gpu

CMD ["bazel-bin/mediapipe/examples/desktop/hand_tracking/hand_tracking_gpu",      "--calculator_graph_config_file=mediapipe/graphs/hand_tracking/hand_tracking_desktop_live_gpu.pbtxt"]
