# postfix

[![Build Status](https://travis-ci.org/dhoppe/puppet-postfix.png?branch=master)](https://travis-ci.org/dhoppe/puppet-postfix)
[![Code Coverage](https://coveralls.io/repos/github/dhoppe/puppet-postfix/badge.svg?branch=master)](https://coveralls.io/github/dhoppe/puppet-postfix)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/postfix.svg)](https://forge.puppetlabs.com/dhoppe/postfix)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/dhoppe/postfix.svg)](https://forge.puppetlabs.com/dhoppe/postfix)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/dhoppe/postfix.svg)](https://forge.puppetlabs.com/dhoppe/postfix)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/dhoppe/postfix.svg)](https://forge.puppetlabs.com/dhoppe/postfix)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with postfix](#setup)
    * [What postfix affects](#what-postfix-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with postfix](#beginning-with-postfix)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This module installs, configures and manages the Postfix service.

## Module Description

This module handles installing, configuring and running Postfix across a range of
operating systems and distributions.

## Setup

### What postfix affects

* postfix package.
* postfix configuration file.
* postfix service.

### Setup Requirements

* Puppet >= 3.0
* Facter >= 1.6
* [Extlib module](https://github.com/voxpupuli/puppet-extlib)
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with postfix

Install postfix with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'postfix': }
```

Install postfix with the recommended parameters.

```puppet
    class { 'postfix':
      config_file_template => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
      config_file_hash     => {
        'mailname' => {
          config_file_path   => '/etc/mailname',
          config_file_string => "${::fqdn}\n",
        },
      },
    }
```

## Usage

Update the postfix package.

```puppet
    class { 'postfix':
      package_ensure => 'latest',
    }
```

Remove the postfix package.

```puppet
    class { 'postfix':
      package_ensure => 'absent',
    }
```

Purge the postfix package ***(All configuration files will be removed)***.

```puppet
    class { 'postfix':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'postfix':
      config_dir_source => "puppet:///modules/postfix/${::operatingsystem}/etc/postfix",
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration
files will be removed)***.

```puppet
    class { 'postfix':
      config_dir_purge  => true,
      config_dir_source => "puppet:///modules/postfix/${::operatingsystem}/etc/postfix",
    }
```

Deploy the configuration file from source.

```puppet
    class { 'postfix':
      config_file_source => "puppet:///modules/postfix/${::operatingsystem}/etc/postfix/main.cf",
    }
```

Deploy the configuration file from string.

```puppet
    class { 'postfix':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'postfix':
      config_file_template => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
    }
```

Deploy the configuration file from custom template ***(Additional parameters can
be defined)***.

```puppet
    class { 'postfix':
      config_file_template     => "postfix/${::operatingsystem}/etc/postfix/main.cf.erb",
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'postfix':
      config_file_hash => {
        'postfix.2nd.conf' => {
          config_file_path   => '/etc/postfix/postfix.2nd.conf',
          config_file_source => "puppet:///modules/postfix/${::operatingsystem}/etc/postfix/postfix.2nd.conf",
        },
        'postfix.3rd.conf' => {
          config_file_path   => '/etc/postfix/postfix.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'postfix.4th.conf' => {
          config_file_path     => '/etc/postfix/postfix.4th.conf',
          config_file_template => "postfix/${::operatingsystem}/etc/postfix/postfix.4th.conf.erb",
        },
      },
    }
```

Disable the postfix service.

```puppet
    class { 'postfix':
      service_ensure => 'stopped',
    }
```

## Reference

### Classes

#### Public Classes

* postfix: Main class, includes all other classes.

#### Private Classes

* postfix::install: Handles the packages.
* postfix::config: Handles the configuration file.
* postfix::service: Handles the service.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present',
'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'postfix'.

#### `package_list`

Determines if additional packages should be managed. Defaults to '['swaks']'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are
'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc/postfix'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are
'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid
values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent'
and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/postfix/main.cf'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0644'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_notify`

Determines if the service should be restarted after configuration changes.
Defaults to 'Service[postfix]'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'Package[postfix]'.

#### `config_file_hash`

Determines which configuration files should be managed via `postfix::define`.
Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `service_ensure`

Determines if the service should be running or not. Valid values are 'running'
and 'stopped'. Defaults to 'running'.

#### `service_name`

Determines the name of service to manage. Defaults to 'postfix'.

#### `service_enable`

Determines if the service should be enabled at boot. Valid values are 'true'
and 'false'. Defaults to 'true'.

#### `myhostname`

Determines the internet domain name of this mail system. Defaults to "$::fqdn".

#### `mydestination`

Determines the list of domains that are delivered via the $local_transport mail
delivery transport. Defaults to "${::fqdn}, localhost.${::domain}, localhost".

#### `recipient`

Determines which email address should be used for the redirecting. Defaults to "admin@${::domain}".

#### `relayhost`

Determines which host should be used as relayhost for outgoing emails. Defaults
to "smtp.${::domain}".

#### `relayport`

Determines which port should be used as relayhost for outgoing emails. Defaults
to '25'.

#### `sasl_user`

Determines which user should be used for authentication with the relayhost.
Defaults to 'undef'.

#### `sasl_pass`

Determines which password should be used for authentication with the relayhost.
Defaults to 'undef'.

## Limitations

This module has been tested on:

* Debian 6/7/8
* Ubuntu 12.04/14.04/16.04
* Gentoo Base System release 2.2

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question
about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a
pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-postfix/graphs/contributors](https://github.com/dhoppe/puppet-postfix/graphs/contributors)
