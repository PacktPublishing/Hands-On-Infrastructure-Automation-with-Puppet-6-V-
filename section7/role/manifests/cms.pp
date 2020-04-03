# role::cms
# install a CMS
class role::cms (
  String[1] $webhost        = $::hostname,
  Stdlib::Port $port        = 80,
  Stdlib::Unixpath $docroot = "/var/www/${webhost}",
  String[1] $username       = 'username',
  String[1] $password       = 'password',
  String[1] $database       = 'database',
) {

  class { 'profile::apache':
    webhost => $webhost,
    port    => $port,
    docroot => $docroot,
    ensure  => 'absent',
  }

  class { 'profile::php': }

  class { 'profile::mysql': }

  class { 'profile::wordpress': 
    docroot  => $docroot,
    username => $username,
    password => $password,
    database => $database,
  }
}
