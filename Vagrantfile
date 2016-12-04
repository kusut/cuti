# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.network :forwarded_port, guest: 8000,  host: 8000

  config.vm.synced_folder ".", "/cuti"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansbl.yml"
  end
end
