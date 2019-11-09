file {'/var/www/html/index.html':
  ensure  => 'file',
  content => epp("hello.epp"),
}
