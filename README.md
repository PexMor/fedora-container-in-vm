# Fedora VM for podman

__TL;DR:__ jump into the running VM with tools ready.

```bash
# run and provision the VM
vagrant up

# enter the VM
vagrant ssh
```

__Note:__ It is __crucial__ to have at least __1 GB__ of RAM allocated for the VM. Otherwise you might encounter strange behaviour caused by __OOM kill__.

## All-in-One Vagrant setup

This directory is a reference cloud image with container tools 
```podman```, ```skopeo``` and ```buildah```
installed. This [Vagrantfile](Vagrantfile) creates a VM with ```nfs-tools``` installed so you can use the VM for independent builds with an option to share artefacts using __NFS__.


### Test it

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

#### Step by step explained

1. ```buildah from fedora``` creates __fedora-working-container__ (the actuall name is shown in CLI)
2. ```buildah run fedora-working-container dnf install httpd -y``` simple install, note the familiar ```dnf install httpd -y``` (forced install of __httpd__ aka __apache 2.4__).
3. ```echo "<html />" >index.html``` make the simplest html page.
4. ```buildah copy fedora-working-container index.html /var/www/html/index.html``` put created __index.html__ into proper place inside the container.
5. ```buildah commit fedora-working-container fedora-myhttpd``` bake the container into permanent image (per user though)
6. ```buildah images``` list the images available (you should see __fedora-httpd__ listed among them).
7. ```podman run -p 8080:80 fedora-myhttpd``` run the container and redirect local port of __8080__ to the container port __80__ (privileged port).

## Builder notes

Some details that you might find useful when doing experiments with this repo and guide.

### Alternative Virsh

In case you __do not have__ ```vagrant```, but only the ```virsh``` go to sub-directory [usingVirsh](usingVirsh). This contains few scripts that can help you to achieve the same but using __virsh__ (libvirt-bin package on Ubuntu).

### Provisioning the VM

The few commands that you have to run as root ```sudo -i``` to get it working when you have vanilla __Fedora__ running somewhere. In the ```Vagrantfile``` the packages are squashed into one line.

__Note:__ _If you do not need the nfs then leave out the ```nfs-tools``` package and ```rpcbind``` service start and enable._

```bash
# switch to root account
sudo -i

# start with updating the system
yum update -y

# install semanage
yum install policycoreutils-python-utils -y

# then install the container tools
yum install podman buildah skopeo -y

# also install the nfs client
yum install nfs-tools -y

# turn on rpcbind
systemctl start rpcbind
systemctl enable rpcbind
```

### Debugging the SE Linux

You might find it useful to turn off __SE Linux__ or better-said switching it into permissive. When that done, you should then spot all issue that would block the execution as log messages.

```bash
# disable at runtime = switch permissive
setenforce 0

# fix the context, strange labeling that was seen on F30
semanage fcontext -a -t container_file_t /var/lib/containers\(/.*\)\?

# apply it to the filesystem
restorecon -R /var/lib/containers

# disable in config to keep it permissive after reboot
sed -i 's/^\s*SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# check state
sestatus
```
