# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"

  config.ssh.forward_agent = true

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update

    sudo apt-get install -y git
    sudo apt-get install -y vim

    # Perl
    sudo apt-get install -y cpanminus
    cpanm Text::CSV
    cpanm Test::Spec
  SHELL

end
