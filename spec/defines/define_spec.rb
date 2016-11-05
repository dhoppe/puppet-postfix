require 'spec_helper'

describe 'postfix::define', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:pre_condition) { 'include postfix' }
      let(:title) { 'main.cf' }

      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/postfix/main.2nd.cf',
            config_file_source: 'puppet:///modules/postfix/Debian/etc/postfix/main.cf'
          }
        end

        it do
          is_expected.to contain_file('define_main.cf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/postfix/Debian/etc/postfix/main.cf',
            'notify'  => 'Service[postfix]',
            'require' => 'Package[postfix]'
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/postfix/main.3rd.cf',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_main.cf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[postfix]',
            'require' => 'Package[postfix]'
          )
        end
      end

      context 'when content template' do
        let(:params) do
          {
            config_file_path: '/etc/postfix/main.4th.cf',
            config_file_template: 'postfix/Debian/etc/postfix/main.cf.erb'
          }
        end

        it do
          is_expected.to contain_file('define_main.cf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[postfix]',
            'require' => 'Package[postfix]'
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) do
          {
            config_file_path: '/etc/postfix/main.5th.cf',
            config_file_template: 'postfix/Debian/etc/postfix/main.cf.erb',
            config_file_options_hash: {
              'key' => 'value'
            }
          }
        end

        it do
          is_expected.to contain_file('define_main.cf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[postfix]',
            'require' => 'Package[postfix]'
          )
        end
      end
    end
  end
end
