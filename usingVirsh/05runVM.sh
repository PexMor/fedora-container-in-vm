#!/bin/bash

ISO=`virsh vol-dumpxml --pool default f30-seed.iso | grep "<path>" | tr "<>" "\n" | grep /var/lib`
IMG=`virsh vol-dumpxml --pool default f30.qcow2 | grep "<path>" | tr "<>" "\n" | grep /var/lib`

virt-install \
    --name f30 \
    --ram=2048 \
    --vcpus=2 --cpu host \
    --hvm \
    --disk path=$IMG \
    --cdrom $ISO \
    --noautoconsole \
    --graphics vnc

exit

kvm -name fedora-cloud \
 -m 2048 \
 -hda tmp/work-disk.qcow2 \
 -cdrom tmp/work-seed.iso \
 -display vnc=
 -netdev tap,id=hostnet0,vhost=on \
 -device virtio-net-pci,netdev=hostnet0,id=net0

# -netdev bridge,br=virbr0,id=net0 \
# -device virtio-net-pci,netdev=net0

