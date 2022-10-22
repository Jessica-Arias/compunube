# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  config.vm.define :servidor1 do |servidor1|
    servidor1.vm.box = "bento/ubuntu-20.04"
    servidor1.vm.network :private_network, ip: "192.168.100.2"
    servidor1.vm.provision "file", source: "haproxy.cfg", destination: "/home/vagrant/haproxy.cfg"
    servidor1.vm.provision "file", source: "config.json", destination: "/home/vagrant/config.json"
    servidor1.vm.provision "file", source: "consul_h.service", destination: "/home/vagrant/consul_h.service"
    servidor1.vm.provision "shell", path: "script_haproxy.sh"
    servidor1.vm.hostname = "servidor1"
    
  end

  config.vm.define :servidor2 do |servidor2|
    servidor2.vm.box = "bento/ubuntu-20.04"
    servidor2.vm.network :private_network, ip: "192.168.100.3"
    servidor2.vm.provision "file", source: "index1.js", destination: "/home/vagrant/index1.js"
    servidor2.vm.provision "file", source: "consul_w.service", destination: "/home/vagrant/consul_w.service"
    servidor2.vm.provision "shell", path: "script_web1.sh"
    servidor2.vm.hostname = "servidor2"
  end

  config.vm.define :servidor3 do |servidor3|
    servidor3.vm.box = "bento/ubuntu-20.04"
    servidor3.vm.network :private_network, ip: "192.168.100.4"
    servidor3.vm.provision "file", source: "index2.js", destination: "/home/vagrant/index2.js"
    servidor3.vm.provision "file", source: "consul_w.service", destination: "/home/vagrant/consul_w.service"
    servidor3.vm.provision "shell", path: "script_web2.sh"
    servidor3.vm.hostname = "servidor3"
  end
	
end

