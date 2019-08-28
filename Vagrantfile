load File.expand_path("localconf") if File.exists?("localconf")

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/30-cloud-base"
  config.vm.define 'f30'
end
