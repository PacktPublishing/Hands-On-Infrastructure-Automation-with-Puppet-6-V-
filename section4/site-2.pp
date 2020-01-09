concat {'/etc/motd': }

package { 'epel-release':
  ensure => 'installed',
}

package { 'figlet':
  ensure => 'installed',
}

exec {'motd.hostname':
  path    => '/bin:/usr/bin',
  command => "figlet $hostname >/etc/motd.hostname",
  creates => '/etc/motd.hostname',
  require => Package['figlet'],
}

exec {'motd.warning':
  path    => '/bin:/usr/bin',
  command => "figlet '* WARNING *'>/etc/motd.warning",
  creates => '/etc/motd.warning',
  require => Package['figlet'],
}

concat::fragment { 'hostname':
  target  => '/etc/motd',
  source  => '/etc/motd.hostname',
  order   => '01',
  require => Exec['motd.hostname'],
}

concat::fragment { 'info':
  target => '/etc/motd',
  content => "${fact('os.name')} ${fact('os.release.major')}\n",
  order => '05',
}

$disclaimer = @(END)
  -----------------------------------------------------------
  This system is for the use of authorized users only.
  Individuals using this computer system without authority,
  or in excess of their authority, are subject to having all
  of their activities on the system monitored and recorded.
  This information will be shared with law enforcement should
  any wrong doing be suspected.
  -----------------------------------------------------------

  | END

concat::fragment { 'warning':
  target => '/etc/motd',
  source => '/etc/motd.warning',
  order  => '10',
}  
concat::fragment { 'disclaimer':
  target  => '/etc/motd',
  content => $disclaimer,
  order   => '20',
} 
