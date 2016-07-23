#$title is the default puppet variable name for the first passd argument
define ghuser {
  $username = $title
  $homedir = "/home/${username}"

  group { $username:
    ensure => present,
  }

  user { $username:
    ensure     => present,
    gid        => $username,
    groups     => ['sudo', $username],
    membership => minimum,
    shell      => '/bin/bash',
    home       => $homedir,
    require    => Group['sudo'],
  }

  file { $homedir:
    ensure  => 'directory',
    owner   => $username,
    group   => $username,
    mode    => '0755',
    require => User[$username],
  }

  file { "${homedir}/.ssh":
    ensure  => 'directory',
    owner   => $username,
    mode    => '0700',
    require => File[$homedir],
  }

  $authorized_keys_path = "${homedir}/.ssh/authorized_keys"

  $user_keys = "https://github.com/${username}.keys"

  exec{"${username}.keys":
    command => "/usr/bin/wget -q ${user_keys} -O ${authorized_keys_path}",
    creates => $authorized_keys_path,
    require => [File["${homedir}/.ssh"], Package['wget']],
  }

  file { $authorized_keys_path:
    mode    => '0600',
    owner   => $username,
    group   => $username,
    require => Exec["${username}.keys"],
  }
}
