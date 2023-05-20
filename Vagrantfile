# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "k8s-master" do |master|
    master.vm.box = "hashicorp/bionic64"
    master.vm.hostname = "k8s-master"
    master.vm.network "private_network", ip: "192.168.56.100"    
    master.vm.provision "shell", path: "master.sh"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = 1800
      vb.cpus = 2
    end
  end
  config.vm.define "k8s-worker1" do |worker1|
    worker1.vm.box = "hashicorp/bionic64"
    worker1.vm.hostname = "k8s-worker1"
    worker1.vm.network "private_network", ip: "192.168.56.101"
    worker1.vm.provision "shell", path: "worker.sh"
  end 
  config.vm.define "k8s-worker2" do |worker2|
    worker2.vm.box = "hashicorp/bionic64"
    worker2.vm.hostname = "k8s-worker2"
    worker2.vm.network "private_network", ip: "192.168.56.102"
    worker2.vm.provision "shell", path: "worker.sh"
  end

  config.vm.box_check_update = false

end