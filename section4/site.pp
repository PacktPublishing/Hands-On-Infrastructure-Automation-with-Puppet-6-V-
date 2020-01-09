node default {
  $release = fact('os.release.major')
  $distro = fact('os.name')
  $count = fact('processors.count')
  $core = fact('processors.models.0')
  notify { "$distro $release on an $count core $core": }
}

