# = Class: postfix::package
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
class postfix::package (
  $ensure = hiera('ensure', $postfix::params::ensure),
) inherits postfix::params {
  validate_re($ensure, '^(absent|present)$')

  package { [
    'exim4',
    'exim4-base',
    'exim4-config',
    'exim4-daemon-light' ]:
      ensure => purged;
    [
    'postfix',
    'swaks' ]:
      ensure => $ensure;
  }
}
