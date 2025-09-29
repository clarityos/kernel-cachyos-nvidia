FROM scratch
LABEL org.opencontainers.image.title="kernel-cachyos-nvidia RPMs"
LABEL org.opencontainers.image.description="CachyOS kernel NVIDIA kmods for akmods-style consumption"

# Copy RPMs from artifact
COPY rpms/ /rpms/

# No CMD needed; purely a container artifact repository
