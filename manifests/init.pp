class thin {
  if ! defined(Package['g++']) {
    package { 'g++':
      ensure => present,
      before => Package['thin'],
    }
  }

  package { 'thin':
    ensure   => present,
    provider => 'gem',
  }

  exec { 'thin-install':
    command   => 'sudo /opt/ruby/bin/thin install',
    path      => ['/usr/bin'],
    creates   => '/etc/init.d/thin',
    require   => Package['thin'],
  }

  service { 'thin':
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    subscribe  => Exec['thin-install'],
  }
}

