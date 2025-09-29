# Use a minimal image since we're just packaging RPMs
FROM scratch

LABEL org.opencontainers.image.title="CachyOS NVIDIA Kmods RPMs"
LABEL org.opencontainers.image.description="CachyOS kernel NVIDIA-open kmod RPMs for akmods-style consumption"

# Copy the RPM artifacts into the image
COPY rpms/kmods/ /rpms/

# No entrypoint or CMD; this image is just a repository of RPMs
