# Stage 1: Builder (optional if RPMs already built in GitHub Actions)
FROM scratch AS builder
# Assuming RPMs are provided by GitHub Actions artifacts.

# Stage 2: Final image
FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia RPMs"
LABEL org.opencontainers.image.description="CachyOS NVIDIA kmod RPMs for akmods-style consumption"

# Copy RPMs into image
COPY rpms/kmods/ /tmp/rpms/kmods/


# Directory structure mimics uBlueOS akmods images:
# /tmp/rpms/kmods -> NVIDIA kernel modules

# No entrypoint or CMD; purely a container artifact repository
