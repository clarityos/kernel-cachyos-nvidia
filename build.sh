#!/usr/bin/env bash
set -euo pipefail

TOPDIR="$PWD/rpmbuild"
SPEC_URL="https://raw.githubusercontent.com/CachyOS/copr-linux-cachyos/refs/heads/master/sources/kernel-cachyos-bore/kernel-cachyos.spec"

echo "==> Preparing RPM build directories..."
mkdir -p "$TOPDIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p rpms/kmods rpms/kernel

echo "==> Downloading spec file..."
curl -L -o "$TOPDIR/SPECS/kernel-cachyos.spec" "$SPEC_URL"

echo "==> Downloading sources..."
spectool -g -C "$TOPDIR/SOURCES" "$TOPDIR/SPECS/kernel-cachyos.spec"

echo "==> Installing build dependencies..."
sudo dnf builddep -y "$TOPDIR/SPECS/kernel-cachyos.spec" || true
sudo dnf install -y rpm-build gcc gcc-c++ make bc bison flex elfutils-devel \
    dwarves zstd python3 python3-pyyaml openssl-devel curl

echo "==> Building kernel + nvidia-open subpackage..."
rpmbuild -bb \
  --define "_topdir $TOPDIR" \
  --define "_build_nv 1" \
  "$TOPDIR/SPECS/kernel-cachyos.spec"

echo "==> Collecting RPMs into rpms/..."
# Move kernel packages
find "$TOPDIR/RPMS" -name "kernel-cachyos*.rpm" -exec cp {} rpms/kernel/ \;
# Move NVIDIA open kmods
find "$TOPDIR/RPMS" -name "*nvidia-open*.rpm" -exec cp {} rpms/kmods/ \;

echo "==> Done. RPMs stored in rpms/"

