# == Class: postfix::params
#
class postfix::params {
  $package_name = $::osfamily ? {
    default => 'postfix',
  }

  $package_list = $::osfamily ? {
    default => ['swaks'],
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/postfix',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/postfix/main.cf',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_notify = $::osfamily ? {
    default => 'Service[postfix]',
  }

  $config_file_require = $::osfamily ? {
    default => 'Package[postfix]',
  }

  $service_name = $::osfamily ? {
    default => 'postfix',
  }

  case $::osfamily {
    'Debian': {
    }
    'Gentoo': {
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
