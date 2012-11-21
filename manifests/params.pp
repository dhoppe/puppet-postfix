class postfix::params {
  case $::lsbdistcodename {
    'squeeze': {
      $email = hiera('email')
      $host  = hiera('host')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
