class postfix {
	validate_string(hiera('email'))
	validate_string(hiera('host'))

	define postfix::aliases($email = false) {
		$t_email = $email ? {
			false   => 'root',
			default => $email,
		}

		file { "$name":
			owner   => root,
			group   => root,
			mode    => '0644',
			alias   => 'aliases',
			content => template('postfix/common/etc/aliases.erb'),
			notify  => Exec['newaliases'],
			require => Package['postfix'],
		}
	}

	define postfix::relayhost($host = false) {
		$t_host = $host ? {
			false   => '',
			default => $host,
		}

		file { "$name":
			owner   => root,
			group   => root,
			mode    => '0644',
			alias   => 'main.cf',
			content => template('postfix/common/etc/postfix/main.cf.erb'),
			notify  => Service['postfix'],
			require => Package['postfix'],
		}
	}

	exec { 'newaliases':
		command     => 'newaliases',
		refreshonly => true,
	}

	postfix::aliases { '/etc/aliases':
		email => hiera('email'),
	}

	file { '/etc/mailname':
		owner   => root,
		group   => root,
		mode    => '0644',
		alias   => 'mailname',
		content => "${::fqdn}\n",
		notify  => Service['postfix'],
		require => Package['postfix'],
	}

	postfix::relayhost { '/etc/postfix/main.cf':
		host => hiera('host'),
	}

	package { [
		'exim4',
		'exim4-base',
		'exim4-config',
		'exim4-daemon-light' ]:
		ensure => absent,
	}

	package { [
		'postfix',
		'swaks' ]:
		ensure => present,
	}

	service { 'postfix':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => false,
		require    => [
			File['aliases'],
			File['mailname'],
			File['main.cf'],
			Package['postfix']
		],
	}
}

# vim: tabstop=3