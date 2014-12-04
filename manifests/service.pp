# == Class: postfix::service
#
class postfix::service {
  if $::postfix::service_name {
    service { 'postfix':
      ensure     => $::postfix::_service_ensure,
      name       => $::postfix::service_name,
      enable     => $::postfix::_service_enable,
      hasrestart => true,
    }
  }
}
