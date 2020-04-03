# role::webserver
# install apache webserver with a single vhost
class role::webserver (
  String[1] $webhost        = $::hostname,
  Stdlib::Port $port        = 80,
  Stdlib::Unixpath $docroot = 80,
) {
  class { 'profile::webserver':
    webhost => $webhost,
    port    => $port,
    docroot => $docroot,
  }
}
