# == Class: postfix::install
#
class postfix::install {
  if $::postfix::package_name {
    package { 'postfix':
      ensure => $::postfix::package_ensure,
      name   => $::postfix::package_name,
    }
  }

  if $::postfix::package_list {
    ensure_resource('package', $::postfix::package_list, { 'ensure' => $::postfix::package_ensure })
  }
}
