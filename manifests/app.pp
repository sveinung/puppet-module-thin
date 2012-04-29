define thin::app($appdir, $port) {
  file { "/etc/thin/${name}.yml":
    ensure  => file,
    content => template('thin/app.yml.erb'),
    require => Exec['thin-install'],
    notify  => Service['thin'],
  }
}
