# = Class: postfix
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
class postfix {
  class { 'package': }
  class { 'config': }
  class { 'service': }

  if defined('monit') {
    monit::file { 'postfix': }
  }
}
