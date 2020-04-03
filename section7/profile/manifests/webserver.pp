# profile::webserver
# install apache with one vhost
class profile::webserver (
  String[1] $webhost,
  Stdlib::Port $port,
  Stdlib::Unixpath $docroot,
) {

  include apache

  apache::vhost { $webhost:
    port    => $port,
    docroot => $docroot,
  }
}
