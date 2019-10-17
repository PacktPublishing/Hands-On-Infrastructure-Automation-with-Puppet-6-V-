file {'motd':
  path    => '/etc/motd',
  content => "Hello World!\n",
}
