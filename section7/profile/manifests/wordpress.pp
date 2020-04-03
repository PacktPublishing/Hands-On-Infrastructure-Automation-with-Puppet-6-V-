class profile::wordpress (
  String[1] $username    = 'username',
  String[1] $password    = 'password',
  String[1] $database    = 'database',
  String[1] $install_dir = '/opt/wordpress',
  String[1] $version     = '5.3',
) {

  # user for wordpress to run as
  group {$username: }
  
  user {$username:
    gid => $username,
  }

  class { 'wordpress':
  version        => $version,
  install_dir    => $install_dir,
  db_name        => $database,
  db_user        => $username,
  db_password    => $password,
  db_host        => 'localhost',
  create_db      => false,
  create_db_user => false,
}
}
