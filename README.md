# fedora-container-in-vm

This repo is to demonstrate how to run buildah, podman and skopeo in portable VM

```bash
# start with updating the system
yum update -y

# then install the container tools
yum install podman buildah skopeo -y

# fix the context
semanage fcontext -a -t container_file_t /var/lib/containers\(/.*\)\?

# apply it to the filesystem
restorecon -R /var/lib/containers
```
