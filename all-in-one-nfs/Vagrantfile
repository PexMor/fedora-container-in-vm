load File.expand_path("localconf") if File.exists?("localconf")

load File.expand_path("kvmconf") if File.exists?("kvmconf")

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/30-cloud-base"
  config.vm.define 'f30'
  # config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.provision 'shell', inline: <<-EOS
    yum update -y
    # install semanage
    yum install policycoreutils-python-utils nfs-utils podman buildah skopeo -y
    # turn on rpcbind
    systemctl start rpcbind
    systemctl enable rpcbind
  EOS
end
