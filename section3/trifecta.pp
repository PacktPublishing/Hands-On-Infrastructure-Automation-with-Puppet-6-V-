package {'httpd':
  ensure => true
}

service { 'httpd':
  ensure  => true,
  enable  => true
  require => Package['httpd'],
}

file { 'index.html':
  ensure  => 'file',
  content => epp('hello.epp'),
  require => Package['httpd'],
}
