class postfix (
  $email = $postfix::params::email,
  $host  = $postfix::params::host
) inherits postfix::params {

  validate_string(hiera('email'))
  validate_string(hiera('host'))

  exec { 'newaliases':
    command     => 'newaliases',
    refreshonly => true,
  }

  postfix::aliases { '/etc/aliases':
    email => $email,
  }

  file { '/etc/mailname':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    alias   => 'mailname',
    content => "${::fqdn}\n",
    notify  => Service['postfix'],
    require => Package['postfix'],
  }

  postfix::relayhost { '/etc/postfix/main.cf':
    host => $host,
  }

  package { [
    'exim4',
    'exim4-base',
    'exim4-config',
    'exim4-daemon-light' ]:
    ensure => absent,
  }

  package { [
    'postfix',
    'swaks' ]:
    ensure => present,
  }

  service { 'postfix':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    require    => [
      File['aliases'],
      File['mailname'],
      File['main.cf'],
      Package['postfix']
    ],
  }
}