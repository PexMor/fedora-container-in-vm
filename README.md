# fedora-container-in-vm

This repo is to demonstrate how to run buildah, podman and skopeo in portable VM

see directory
[All in One Vagrant for container tools](all-in-one)

```bash
# jump inside vagrant
vagrant ssh
```

```bash
# switch to root account
sudo -i

# start with updating the system
yum update -y

# install semanage
yum install policycoreutils-python-utils -y

# then install the container tools
yum install podman buildah skopeo -y
```

Debugging the SE linux

```bash
# disable at runtime
setenforce 0

# fix the context
semanage fcontext -a -t container_file_t /var/lib/containers\(/.*\)\?

# apply it to the filesystem
restorecon -R /var/lib/containers

# disable in config
sed -i 's/^\s*SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# check state
sestatus
```

## Buildah Test

extracted from [https://docs.fedoraproject.org/en-US/iot/buildah/](https://docs.fedoraproject.org/en-US/iot/buildah/)

```bash
buildah from fedora
buildah run fedora-working-container dnf install httpd -y
echo "<html />" >index.html
buildah copy fedora-working-container index.html /var/www/html/index.html
buildah config --entrypoint "/usr/sbin/httpd -DFOREGROUND" fedora-working-container
buildah commit fedora-working-container fedora-myhttpd
buildah images
podman run fedora-myhttpd
```
