RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    cmake \
    clang \
    libvulkan-dev \
    pkg-config \
    python3 \
    wget \
    ninja-build \
    glslang-tools \
    spirv-tools \
    libssl-dev \
    libshaderc-dev \
    glslc \
    && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup component add rustfmt
WORKDIR /build
RUN git clone https://github.com/LibreTranslate/LTEngine --recursive . || \
    (git fetch && git pull && git submodule update --init --recursive)
RUN rustup update
RUN cargo build --features vulkan --release
FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    libgomp1 \
    libvulkan1 \
    mesa-vulkan-drivers \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /build/target/release/ltengine /app/ltengine
ENTRYPOINT ["/bin/bash", "-c", "/app/ltengine -m ${MODEL:-gemma3-4b}"]
