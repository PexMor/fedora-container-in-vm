# Virsh use

This directory contains few script that might help you run the VM of __Fedora 30__.
The image does not get provisioned the same as the vagranted VM. Althought it is just few lines.

file: __provision.sh__

```bash
yum update -y
# install semanage
yum install policycoreutils-python-utils nfs-utils podman buildah skopeo -y
# turn on rpcbind
systemctl start rpcbind
systemctl enable rpcbind
```

## Virsh scripts

* ```01getImage.sh``` - downloads the __Fedora 30__ cloud image
* ```02mkDisk.sh``` - unused, but creates the linked image for __KVM__ (for use w/o virsh)
* ```03mkCloudInit.sh``` - prepare the VM __cloud-init__ ISO image
* ```04uploadImages.sh``` - puts the disk and ISO into virsh pools
* ```05runVM.sh``` - start the VM using ```virsh```

When those scripts are finished you should have access to the machine using ```ssh```, ```ansible```.

