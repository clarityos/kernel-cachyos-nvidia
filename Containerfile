FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia RPMs"
LABEL org.opencontainers.image.description="CachyOS NVIDIA-open kmod RPMs for akmods-style consumption"

# Copy RPMs from previous workflow
COPY rpms/kmods/ /rpms/kmods/

# No CMD — this is just a container artifact repository
