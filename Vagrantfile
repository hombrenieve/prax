# -*- mode: ruby -*-
# vi: set ft=ruby expandtab tabstop=2 shiftwidth=2 :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Box
  config.vm.box = "ubuntu/bionic64"

  config.vm.define "prax", primary: true do |node|
    node.vm.hostname =  "prax"
  end

  # Mem and vCPU
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.linked_clone = true
  end

  # Disk size
  config.disksize.size = "20GB"

  # Default network should work
  config.vm.network "private_network", type: "dhcp"

  # X11 & Compression
  config.ssh.forward_x11 = true

  # Provision
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false

end

# EOF
