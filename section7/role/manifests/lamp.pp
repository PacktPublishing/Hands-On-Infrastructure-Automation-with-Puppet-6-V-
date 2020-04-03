# role::lamp
# Linux Apache MySQL PHP
class role::lamp (
  String[1] $webhost        = $::hostname,
  Stdlib::Port $port        = 80,
  Stdlib::Unixpath $docroot = "/var/www/${webhost}",
  String[1] $username       = 'username',
  String[1] $password       = 'password',
  String[1] $database       = 'database',
) {

  class { 'profile::webserver':
    webhost => $webhost,
    port    => $port,
    docroot => $docroot,
  }

  class { 'profile::php': }

  class { 'profile::mysql': }
}
