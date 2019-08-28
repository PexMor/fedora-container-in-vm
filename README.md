# fedora-container-in-vm

This repo is to demonstrate how to run buildah, podman and skopeo in portable VM

```bash
# start with updating the system
yum update -y

# install semanage
yum install policycoreutils-python-utils -y

# then install the container tools
yum install podman buildah skopeo -y

# fix the context
semanage fcontext -a -t container_file_t /var/lib/containers\(/.*\)\?

# apply it to the filesystem
restorecon -R /var/lib/containers

# disable at runtime
sudo selinux 0

# disable in config
sed -i 's/^\s*SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# check state
sestatus
```
