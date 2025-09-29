# --- Builder stage ----------------------------------------------------------
# Optional: If you ever decide to build inside the container instead of CI
FROM fedora:43 AS builder
# RUN dnf -y install rpm-build ... && rpmbuild ...  # <- Not needed if GitHub Actions builds rpms.

# --- Final artifact stage ---------------------------------------------------
FROM scratch

# OCI Metadata
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia RPMs" \
      org.opencontainers.image.description="CachyOS kernel and NVIDIA-open kmod RPMs for akmods-style consumption" \
      org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/${{ github.repository }}" \
      org.opencontainers.image.authors="ClarityOS Build System"

# Copy all RPMs into the root of the image
COPY rpms/ /rpms/

# No entrypoint or CMD — this image is used as a data source (like ublue/akmods)
