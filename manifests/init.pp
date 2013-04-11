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
  anchor { 'postfix::begin': } ->
  class { 'package': }         ->
  class { 'config': }          ->
  class { 'service': }         ->
  anchor { 'postfix::end': }

  if defined('monit') {
    monit::file { 'postfix': }
  }
}
