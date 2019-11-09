file {'/var/www/html/index.html':
  ensure  => 'file',
  content => "Hello World!\n",
}
