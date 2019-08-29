# All-in-One Vagrant setup

This directory is test reference cloud image with container tools installed:

```podman```, ```skopeo``` and ```buildah```

```bash
# run and provision the VM
vagrant up

# enter the VM
vagrant ssh
```

Then feel free to run [https://docs.fedoraproject.org/en-US/iot/buildah/](https://docs.fedoraproject.org/en-US/iot/buildah/)
or refer to  [Main README.md](../README.md)

__Note:__
This ```Vagrantfile``` creates VM with ```nfs-tools``` installed so you can use the VM for independet builts that
can be shared via __NFS__.

__To-Do:__ add (batch) upload tools, i.e. jfrog and/or __CIFS__ (smb,samba) windows sharing.
