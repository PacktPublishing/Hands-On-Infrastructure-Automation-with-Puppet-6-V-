file {'/var/www/html/index.html':
  ensure  => 'file',
  content => epp("/vagrant/section3/hello.epp"),
}
