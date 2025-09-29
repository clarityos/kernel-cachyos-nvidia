FROM fedora:43 AS builder
# (Optional) Build inside this stage if you want a single-stage image
# but normally GitHub Actions builds rpms and copies into this.

FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia RPMs"
LABEL org.opencontainers.image.description="CachyOS kernel and NVIDIA-open kmod RPMs for akmods-style consumption"

# Copy RPMs from build artifact
COPY rpms/ /rpms/

# No CMD—this is purely a container artifact repository
