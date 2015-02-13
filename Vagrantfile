# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Use Ubuntu Trusty (14.x) 64-bit
  config.vm.box = "ubuntu/trusty64"

  # Virtualbox GUI
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.gui = true
    v.customize ["modifyvm", :id, "--usb", "on"]
    # fix for slow network
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  # Install Dependencies (window manager)
  config.vm.provision :shell, path: "scripts/install_deps.sh"


  Vagrant.configure("2") do |config|
    config.vm.provision "docker" do |d|
      if ENV["DOCKER_PULL"]
        d.pull_images "samtstern/android-base"
        d.pull_images "samtstern/android-studio"
      end
      if ENV["DOCKER_BUILD"]
        d.build_image "/vagrant/docker/android-base", args: "-t samtstern/android-base"
        d.build_image "/vagrant/docker/android-studio", args: "-t samtstern/android-studio"
      end
    end
  end

  # install profile.d hooks, need to to this with shell
  # because file provisions are not run as sudo
  config.vm.provision :shell,
    inline: "cp /vagrant/scripts/android_vagrant_env.sh /etc/profile.d/"
end
