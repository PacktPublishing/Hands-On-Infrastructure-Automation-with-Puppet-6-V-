# role::lap
# Linux Apache PHP
class role::lap (
  String[1] $webhost        = $::hostname,
  Stdlib::Port $port        = 80,
  Stdlib::Unixpath $docroot = "/var/www/${webhost}",
) {

  class { 'profile::apache':
    webhost => $webhost,
    port    => $port,
    docroot => $docroot,
  }

  class { 'profile::php': }
}
