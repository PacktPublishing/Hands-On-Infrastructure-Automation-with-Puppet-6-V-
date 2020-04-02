define admin_user (
  Enum['present', 'absent'] $ensure = 'present',
  String[1] $home = "/home/${title}",
  Enum['/bin/bash','/bin/sh'] $shell = '/bin/bash',
  String[1] $group = "${title}-group",
  ) {
    if ($ensure == 'absent') {
      # user then group
      User[$title] { before => Group[$group] }
      File[$home] { force => true }
    } else {
      User[$title] { require => Group[$group] }
    }

    group { $group:
      ensure => $ensure,
    }

    user { $title:
      ensure => $ensure,
      home   => $home,
      shell  => $shell,
      gid    => $group,
    }

    if ($ensure == 'present') {
      file { $home:
        ensure  => 'directory',
        owner   => $title,
        group   => $group,
        require => User[$title],
      }
    } else {
      file { $home:
        ensure  => $ensure,
        require => User[$title],
      }
    }

    if ($shell == '/bin/bash') {
      file { "${home}/.bashrc":
        ensure  => $ensure,
        content => "export PATH=\$PATH:${home}/bin\n",
        owner   => $title,
        group   => $group,
        require => User[$title],
      }
      $profile = @("PROFILE"/$)
        if [ "\$BASH" ]; then
          if [ -f ~/.bashrc ]; then
            . ~/.bashrc
          fi
        fi
        echo Admin User: $title
        |PROFILE
      file {"${home}/.profile":
        ensure  => $ensure,
        content => $profile,
        owner   => $title,
        group   => $group,
        require => User[$title],
      }
    }
  }

admin_user {'bob': }
admin_user {'alias': shell => '/bin/sh'}
#admin_user {'bob': ensure => 'absent'}
#admin_user {'alice': shell => '/bin/sh', ensure => 'absent' }
