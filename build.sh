#!/usr/bin/env bash
set -euo pipefail

TOPDIR="$PWD/rpmbuild"
SPEC_URL="https://raw.githubusercontent.com/CachyOS/copr-linux-cachyos/refs/heads/master/sources/kernel-cachyos-bore/kernel-cachyos.spec"

echo "==> Preparing RPM build directories..."
mkdir -p "$TOPDIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p rpms/kmods

echo "==> Downloading spec file..."
curl -L -o "$TOPDIR/SPECS/kernel-cachyos.spec" "$SPEC_URL"

echo "==> Downloading sources..."
spectool -g -C "$TOPDIR/SOURCES" "$TOPDIR/SPECS/kernel-cachyos.spec"

echo "==> Installing build dependencies..."
# Install only what's needed to build the kmod
sudo dnf builddep -y "$TOPDIR/SPECS/kernel-cachyos.spec" || true
sudo dnf install -y rpm-build gcc gcc-c++ make bc bison flex elfutils-devel \
    dwarves zstd python3 python3-pyyaml openssl-devel curl

echo "==> Building only NVIDIA open kernel modules..."
rpmbuild -bb \
  --define "_topdir $TOPDIR" \
  --define "_build_nv 1" \
  --define "_without_kernel 1" \
  "$TOPDIR/SPECS/kernel-cachyos.spec" \
  --with nvidia-open \
  --without core \
  --without modules \
  --without devel \
  --without devel-matched

echo "==> Collecting NVIDIA RPMs..."
find "$TOPDIR/RPMS" -name "*nvidia-open*.rpm" -exec cp {} rpms/kmods/ \;

echo "==> Done. NVIDIA-open kmod RPMs stored in rpms/kmods/"
