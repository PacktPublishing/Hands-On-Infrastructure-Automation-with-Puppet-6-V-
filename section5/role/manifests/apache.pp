# role::apache
# install apache webserver with a single vhost
class role::apache (
  String[1] $webhost        = $::hostname,
  Stdlib::Port $port        = 80,
  Stdlib::Unixpath $docroot = "/var/www/${webhost}",
) {
  class { 'profile::apache':
    webhost => $webhost,
    port    => $port,
    docroot => $docroot,
  }
}
