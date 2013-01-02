# = Class: postfix::service
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
class postfix::service (
  $ensure_enable  = hiera('ensure_enable', $postfix::params::ensure_enable),
  $ensure_running = hiera('ensure_running', $postfix::params::ensure_running),
  $disabled_hosts = hiera('disabled_hosts', $postfix::params::disabled_hosts),
) inherits postfix::params {
  validate_bool($ensure_enable)
  validate_re($ensure_running, '^(running|stopped)$')
  validate_array($disabled_hosts)

  service { 'postfix':
    ensure     => $ensure_running,
    enable     => $ensure_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Class['postfix::config'],
  }

  if $::hostname in $disabled_hosts {
    Service <| title == 'postfix' |> {
      ensure => stopped,
      enable => false,
    }
  }
}
