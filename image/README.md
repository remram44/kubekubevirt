get OS image: `curl -Lo ubuntu-24.04.qcow2 'https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img'`

resize image: `qemu-img resize ubuntu-24.04.qcow2 100G`

create SSH key and `cloud-init.iso`

boot VM: `qemu-system-x86_64 -enable-kvm -cpu host -no-reboot -drive id=root,file=ubuntu-24.04.qcow2,format=qcow2,if=virtio -drive id=cidata,file=cloud-init.iso,media=cdrom,readonly=on,if=virtio -netdev "user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22" -device virtio-net-pci,netdev=net0 -m 8192 -smp 4`

SSH into VM: `ssh -p 2222 ubuntu@127.0.0.1`

install Kubernetes

clear /var/cache/apt/archives, /var/lib/apt/lists

reset cloud-init: `rm /home/ubuntu/.ssh/authorized_keys && cloud-init clean --logs --machine-id --configs all --seed --reboot`

shrink filesystem and image: https://superuser.com/a/1081649

build image with ([reference](https://github.com/kubevirt/containerized-data-importer/blob/main/doc/image-from-registry.md)): `docker build . -t ghcr.io/remram44/kubekubevirt:ubuntu-24.04`
