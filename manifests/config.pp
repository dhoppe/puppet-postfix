# = Class: postfix::config
#
# This module manages postfix
#
# == Parameters: none
#
# == Actions:
#
# == Requires: see Modulefile
#
# == Sample Usage:
#
class postfix::config (
  $ensure    = hiera('ensure', $postfix::params::ensure),
  $alias     = hiera('alias', $postfix::params::alias),
  $relayhost = hiera('relayhost', $postfix::params::relayhost),
) inherits postfix::params {
  validate_re($ensure, '^(absent|present)$')
  validate_string($alias)
  validate_string($relayhost)

  exec { 'newaliases':
    command     => '/usr/bin/newaliases',
    refreshonly => true,
    subscribe   => Mailalias['root'],
    require     => Class['postfix::package'],
  }

  file {
    '/etc/aliases':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644';
    '/etc/mailname':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "${::fqdn}\n",
      notify  => Service['postfix'],
      require => Package['postfix'];
    '/etc/postfix/main.cf':
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('postfix/common/etc/postfix/main.cf.erb'),
      notify  => Service['postfix'],
      require => Package['postfix'];
  }

  mailalias { 'root':
    ensure    => present,
    recipient => $alias,
  }
}
