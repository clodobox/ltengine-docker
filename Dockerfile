FROM rust:latest as builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    clang \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Clone repository
WORKDIR /build
RUN git clone https://github.com/LibreTranslate/LTEngine --recursive . || \
    (git fetch && git pull && git submodule update --init --recursive)

# Update Rust to handle Rust 2024 edition
RUN rustup update

# Build for CPU only
RUN cargo build --release

FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    libgomp1 \  # Ajout de libgomp1 pour libgomp.so.1
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy executable
COPY --from=builder /build/target/release/ltengine /app/ltengine

# Create folder for models
RUN mkdir -p /app/models

# Exposed port
EXPOSE 5050

# Use the MODEL environment variable at runtime
ENTRYPOINT ["/bin/bash", "-c", "/app/ltengine -m ${MODEL:-gemma3-4b}"]
