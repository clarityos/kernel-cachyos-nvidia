FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia Kernel RPMs"
LABEL org.opencontainers.image.description="CachyOS kernel RPMs with NVIDIA-open modules built-in"

COPY rpms/kernel/ /rpms/
