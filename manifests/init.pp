# This module manages MCollective.
#
# == Parameters
#
# [*version*]
#   The version of the MCollective package(s) to be installed.
# [*server*]
#   Boolean determining whether you would like to install the server component.
# [*server_config*]
#   The content of the MCollective server configuration file.
# [*server_config_file*]
#   The full path to the MCollective server configuration file.
# [*client*]
#   Boolean determining whether you would like to install the client component.
# [*client_config*]
#   The content of the MCollective client configuration file.
# [*client_config_file*]
#   The full path to the MCollective client configuration file.
# [*stomp_server*]
#   The hostname of the stomp server.
# [*mc_security_provider*]
#   The MCollective security provider
# [*mc_security_psk*]
#   The MCollective pre shared key
#
# == Examples
#
# The module works with sensible defaults:
#
#     node default {
#       include mcollective
#     }
#
class mcollective(

  $package_version            = $mcollective::params::package_version,
  $manage_packages            = true,
  $manage_plugins             = true,
  $server                     = true,
  $server_config_file         = '/etc/mcollective/server.cfg',
  $server_ssl_server_private  = $mcollective::params::server_ssl_server_private,
  $server_ssl_server_public   = $mcollective::params::server_ssl_server_public,
  $server_ssl_client_cert_dir = $mcollective::params::server_ssl_client_cert_dir,
  $client                     = false,
  $client_config_file         = '/etc/mcollective/client.cfg',
  $client_ssl_server_public   = $mcollective::params::client_ssl_server_public,
  $client_ssl_client_private  = $mcollective::params::client_ssl_client_private,
  $client_ssl_client_public   = $mcollective::params::client_ssl_client_public,
  $stomp_server               = $mcollective::params::stomp_server,
  $stomp_port                 = $mcollective::params::stomp_port,
  $mc_security_provider       = $mcollective::params::mc_security_provider,
  $mc_security_psk            = $mcollective::params::mc_security_psk,
  $mc_topicprefix             = $mcollective::params::mc_topicprefix,
  $mc_libdir                  = $mcollective::params::mc_libdir,
  $mc_loglevel                = $mcollective::params::mc_loglevel,
  $mc_logfile                 = $mcollective::params::mc_logfile,
  $mc_daemonize               = $mcollective::params::mc_daemonize,
  $nrpe_dir                   = $mcollective::params::nrpe_dir,
  $fact_source                = $mcollective::params::fact_source,
  $yaml_facter_source         = '/etc/mcollective/facts.yaml',
  $stomp_user                 = $mcollective::params::stomp_user,
  $stomp_passwd               = $mcollective::params::stomp_passwd

  ) inherits mcollective::params {

  $v_bool = [ '^true$', '^false$' ]
  validate_bool($manage_packages)
  validate_bool($manage_plugins)
  validate_bool($server)
  validate_bool($client)
  validate_re($server_config_file, '^/')
  validate_re($client_config_file, '^/')
  validate_re($package_version, '^[._0-9a-zA-Z:-]+$')
  validate_re($mc_security_provider, '^[a-zA-Z0-9_]+$')
  validate_re($mc_security_psk, '^[^ \t]+$')
  validate_re($fact_source, '^facter$|^yaml$')

  # Service Name:
  $service_name = 'mcollective'

  # Add anchor resources for containment
  anchor { 'mcollective::begin': }
  anchor { 'mcollective::end': }

  if $server {
    class { 'mcollective::server':
      package_version => $package_version,
      service_name    => $service_name,
      config          => template('mcollective/server.cfg.erb'),
      config_file     => $server_config_file,
      require         => Anchor['mcollective::begin'],
    }
    # Also manage the plugins
    if $manage_plugins {
      class { 'mcollective::plugins':
        require => Class['mcollective::server'],
        before  => Anchor['mcollective::end'],
      }
    }
  }

  if $client {
    class { 'mcollective::client':
      package_version         => $version,
      config          => template('mcollective/client.cfg.erb'),
      config_file     => $client_config_file,
      manage_packages => $manage_packages,
      require         => Anchor['mcollective::begin'],
      before          => Anchor['mcollective::end'],
    }
  }
}
