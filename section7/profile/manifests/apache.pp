# profile::apache
# install apache with one vhost
class profile::apache (
  String[1] $webhost,
  Stdlib::Port $port,
  Stdlib::Unixpath $docroot,
  String[1] $ensure = 'file',
) {

  class {'apache':
    default_vhost => false,
    mpm_module    => 'prefork',
  }

  apache::vhost { $webhost:
    port    => $port,
    docroot => $docroot,
  }
  file { 'index.html':
    ensure  => $ensure,
    path    => "${docroot}/index.html",
    content => epp('profile/index.html.epp'),
    mode    => '0644',
  }
}
