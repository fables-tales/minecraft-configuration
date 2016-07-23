class sudosetup {
  file { "/etc/sudoers":
    ensure => "present",
    content => template("sudosetup/sudoers"),
  }

  group { 'sudo':
    ensure => present,
  }
}
