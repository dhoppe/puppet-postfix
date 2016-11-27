source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

group :test do
  gem 'coveralls',                                                 :require => false if RUBY_VERSION >= '2.0.0'
  gem 'json_pure', '<= 2.0.1',                                     :require => false if RUBY_VERSION < '2.0.0'
  gem 'metadata-json-lint',                                        :require => false
  gem 'mocha', '>= 1.2.1',                                         :require => false
  gem 'puppet-blacksmith',                                         :require => false
  gem 'puppet-lint-absolute_classname-check',                      :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check', :require => false
  gem 'puppet-lint-leading_zero-check',                            :require => false
  gem 'puppet-lint-trailing_comma-check',                          :require => false
  gem 'puppet-lint-unquoted_string-check',                         :require => false
  gem 'puppet-lint-variable_contains_upcase',                      :require => false
  gem 'puppet-lint-version_comparison-check',                      :require => false
  gem 'puppet-strings', '~> 0.99.0',                               :require => false
  gem 'puppetlabs_spec_helper', '~> 1.2.2',                        :require => false
  gem 'rspec-puppet', '~> 2.5',                                    :require => false
  gem 'rspec-puppet-facts',                                        :require => false
  gem 'rspec-puppet-utils',                                        :require => false
  gem 'rubocop-rspec', '~> 1.6',                                   :require => false if RUBY_VERSION >= '2.3.0'
  gem 'simplecov-console',                                         :require => false if RUBY_VERSION >= '2.0.0'
end

group :development do
  gem 'guard-rake',  :require => false
  gem 'travis',      :require => false
  gem 'travis-lint', :require => false
end

group :system_tests do
  if beaker_version = ENV['BEAKER_VERSION']
    gem 'beaker', *location_for(beaker_version)
  end
  if beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION']
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec', :require => false
  end
  gem 'beaker-puppet_install_helper', :require => false
  gem 'serverspec',                   :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, :require => false, :groups => [:test]
else
  gem 'facter', :require => false, :groups => [:test]
end

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 4.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
