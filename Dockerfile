FROM rust:1.74-slim-bookworm as builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    clang \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Clone repository
WORKDIR /build
RUN git clone https://github.com/LibreTranslate/LTEngine --recursive .

# Build for CPU only
RUN cargo build --release

FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
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
