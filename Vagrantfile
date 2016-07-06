# -*- mode: ruby -*-
# vi: set ft=ruby :
unless Vagrant.has_plugin?("vagrant-vbguest")
  raise "Missing vbguest plugin!
Run the following command:
  vagrant plugin install vagrant-vbguest"
end
SCRIPT_PATH="https://raw.githubusercontent.com/gitphill/shell/master/"
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "ssl.dev"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "OpenSSL"
    vb.memory = 1024
    vb.cpus = 2
  end
  config.vm.provision :shell do |sh|
    sh.path = SCRIPT_PATH + "start-in.sh"
    sh.args = ["vagrant", "/vagrant"]
    sh.keep_color = true
  end
  config.vm.provision :shell do |sh|
    sh.path = SCRIPT_PATH + "docker.sh"
    sh.args = "vagrant"
    sh.keep_color = true
  end
end
