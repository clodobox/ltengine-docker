FROM rust:latest AS builder
RUN apt-get update && apt-get install -y \
    git \
    clang \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /build
RUN git clone https://github.com/LibreTranslate/LTEngine --recursive . || \
    (git fetch && git pull && git submodule update --init --recursive)
RUN rustup update
RUN cargo build --release
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    libgomp1 \
    git \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /build/target/release/ltengine /app/ltengine
ENTRYPOINT ["/bin/bash", "-c", "/app/ltengine -m ${MODEL:-gemma3-4b}"]
