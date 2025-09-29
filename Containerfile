FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia kmods"
LABEL org.opencontainers.image.description="Prebuilt nvidia-open kmod RPMs for CachyOS kernel"

# Store RPMs inside the container
COPY rpms/kmods/ /rpms/
