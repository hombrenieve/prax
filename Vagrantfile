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

  # Sync repos
  config.vm.synced_folder "../repos", "/repos"

  # Provision
  config.vm.provision "file", source: "tmux.conf", destination: "~/.tmux.conf"
  config.vm.provision "file", source: "gitconfig", destination: "~/.gitconfig"
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false

  
  # Some ports
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8181, host: 8181
  config.vm.network "forwarded_port", guest: 8282, host: 8282
  config.vm.network "forwarded_port", guest: 8383, host: 8383
  config.vm.network "forwarded_port", guest: 8484, host: 8484
  config.vm.network "forwarded_port", guest: 8585, host: 8585

end

# EOF
