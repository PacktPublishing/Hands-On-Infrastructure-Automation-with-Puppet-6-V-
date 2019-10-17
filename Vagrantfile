# -*- mode: ruby -*-
# vi: set ft=ruby :

$rhel = <<EOF
yum install -y https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum install -y puppet-agent
EOF
$debian = <<EOF
dpkg -s puppet-agent >/dev/null
if [ $? -ne 0 ]; then
  wget http://apt.puppet.com/puppet6-release-buster.deb
  dpkg -i puppet6-release-buster.deb
  apt-get update
  apt-get install -y puppet-agent
fi
EOF
$git = <<EOF
dpkg -s puppet-agent >/dev/null
if [ $? -ne 0 ]; then
  wget http://apt.puppet.com/puppet6-release-buster.deb
  dpkg -i puppet6-release-stretch.deb
  apt-get update
  apt-get install -y puppet-agent
fi
/opt/puppetlabs/bin/puppet apply /home/vagrant/git.pp
EOF
Vagrant.configure("2") do |config|
  config.vm.define "centos" do |centos|
    centos.vm.box = "centos/7"
    centos.vm.provision "shell", inline: $rhel
    centos.vm.hostname = "cookbook.example.com"
    centos.vm.network "private_network", ip: "192.168.50.10",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "debian" do |debian|
    debian.vm.box = "debian/buster64"
    debian.vm.provision "shell", inline: $debian
    debian.vm.hostname = "cookbook.example.com"
  end

  config.vm.define "git" do |git|
    git.vm.box = "debian/buster64"
    git.vm.provision "file", source: "git.pp", destination: "/home/vagrant/git.pp"
    git.vm.provision "shell", inline: $git
    git.vm.hostname = "git.example.com"
    git.vm.network "private_network", ip: "192.168.50.5",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "testnode" do |testnode|
    testnode.vm.box = "centos/7"
    testnode.vm.provision "shell", inline: $rhel
    testnode.vm.hostname = "testnode.example.com"
    testnode.vm.network "private_network", ip: "192.168.50.20",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "centos/7"
    puppet.vm.provision "shell", inline: $rhel
    puppet.vm.hostname = "puppet.example.com"
    puppet.vm.network "private_network", ip: "192.168.50.100",
      virtualbox__intnet: "puppet"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 1500
    end
  end
end
