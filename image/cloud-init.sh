#!/bin/sh

cd "$(dirname "$0")"
DEST="$(pwd)"
TEMPDIR="$(mktemp -d)"
cd "$TEMPDIR"

# Build cloud-init volume ISO
printf 'instance-id: kubekubevirt-controlplane-0\nlocal-hostname: kubekubevirt-controlplane-0\n' > meta-data
printf '#cloud-config\npassword: %s\nchpasswd:\n  expire: false\nssh_pwauth: true\n' "hackme" > user-data
genisoimage -output "$DEST/cloud-init.iso" -volid cidata -joliet -rock user-data meta-data

# Clean up
cd /
rm -rf "$TEMPDIR"
