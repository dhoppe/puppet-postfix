# = Class: postfix::params
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
class postfix::params {
  case $::lsbdistcodename {
    'squeeze', 'wheezy': {
      $ensure         = present
      $ensure_enable  = true
      $ensure_running = running
      $disabled_hosts = []
      $alias          = "admin@${::domain}"
      $relayhost      = "mail.${::domain}"
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
