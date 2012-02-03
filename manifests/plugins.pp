# This class deploys the default set of MCollective plugins
#
# == Parameters
#
# == Examples
#
class mcollective::plugins (
  $plugin_base = $mcollective::params::plugin_base,
  $plugin_subs = $mcollective::params::plugin_subs
) inherits mcollective::params {

  File {
    owner => '0',
    group => '0',
    mode  => '0644',
  }

  # $plugin_base and $plugin_subs are meant to be arrays.
  file { $plugin_base:
    ensure  => directory,
    #purge   => true,
    #recurse => true,
    require => Class['mcollective::server::package'],
  }
  file { $plugin_subs:
    ensure => directory,
    #purge   => true,
    #recurse => true,
    notify => Class['mcollective::server::service'],
  }

  mcollective::plugin { 'facter_facts':
    ensure => present,
    type   => 'facts',
  }
  mcollective::plugin { 'yaml_facts':
    ensure => present,
    type   => 'facts',
  }
  mcollective::plugin { 'service':
    ensure      => present,
    type        => 'agent',
    ddl         => true,
    application => true,
  }
  mcollective::plugin { 'package':
    ensure      => present,
    type        => 'agent',
    ddl         => true,
    application => true,
  }
  mcollective::plugin { 'meta':
    ensure      => present,
    type        => 'registration',
    ddl         => false,
    application => false,
  }
  mcollective::plugin { 'nrpe':
    ensure      => present,
    type        => 'agent',
    ddl         => true,
    application => true,
  }
  mcollective::plugin { 'puppetd':
    ensure      => present,
    type        => 'agent',
    ddl         => true,
    application => true,
  }
  mcollective::plugin { 'actionpolicy':
    ensure      => present,
    type        => 'util',
  }
}

