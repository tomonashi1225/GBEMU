FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ARG ZIG_VERSION=0.16.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        git-lfs \
        jq \
        xz-utils \
        gdb \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    case "$(uname -m)" in \
        x86_64) ZIG_ARCH="x86_64" ;; \
        aarch64|arm64) ZIG_ARCH="aarch64" ;; \
        *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;; \
    esac; \
    curl -fsSL https://ziglang.org/download/index.json -o /tmp/zig-index.json; \
    ZIG_URL="$(jq -r \
        --arg version "${ZIG_VERSION}" \
        --arg target "${ZIG_ARCH}-linux" \
        '.[$version][$target].tarball' \
        /tmp/zig-index.json)"; \
    test "${ZIG_URL}" != "null"; \
    curl -fsSL "${ZIG_URL}" -o /tmp/zig.tar.xz; \
    mkdir -p /opt/zig; \
    tar -xJf /tmp/zig.tar.xz \
        --strip-components=1 \
        -C /opt/zig; \
    ln -s /opt/zig/zig /usr/local/bin/zig; \
    zig version; \
    rm -f /tmp/zig-index.json /tmp/zig.tar.xz