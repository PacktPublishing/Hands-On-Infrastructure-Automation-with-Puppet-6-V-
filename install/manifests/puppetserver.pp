package {'puppetserver': 
  ensure => installed
}

file {'sysconfig-puppetserver':
  ensure => present,
  path   => '/etc/sysconfig/puppetserver',
  source => '/vagrant/install/files/sysconfig-puppetserver',
}

service {'puppetserver':
  ensure => true,
  enable => true,
}
