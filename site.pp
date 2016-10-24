
$packages = [ 
  'wget',
]
class { "sudosetup":
}

package { $packages:
  ensure => present,
}

ghuser {'samphippen':
  require => Class['sudosetup'],
}

$friends = [
  'samphippen',
  'neoncode',
  'Lukeus_Maximus',
  'Neosyfie',
]

class { 'minecraft':
  source             => '1.10.2',
  heap_size          => 3000,
  difficulty         => 3,
  motd               => 'Computers',
  ops                => $friends,
  white_list         => true,
  white_list_players => $friends,
  autostart          => true,
  manage_java        => true,
  level_type         => 'AMPLIFIED',
  max_build_height   => 512,
}

file { "/opt/minecraft/eula.txt":
  ensure => "present",
  content => "eula=true",
  require => Class["minecraft"],
}
