# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Use Ubuntu Trusty (14.x) 32-bit
  config.vm.box = "ubuntu/trusty32"

  # Install Dependencies (window manager, java, etc)
  config.vm.provision :shell, path: "install_deps.sh"

  # Install Android Studio
  config.vm.provision :shell, path: "install_studio.sh"

  # Virtualbox GUI
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.gui = true
  end
end
