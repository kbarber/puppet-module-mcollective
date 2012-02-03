# This class installs the MCollective server component for your nodes
#
# == Parameters
#
# [*version*]
#   The version of the MCollective package(s) to be installed.
# [*config*]
#   The content of the MCollective client configuration file.
# [*config_file*]
#   The full path to the MCollective client configuration file.
# TODO: finish parameter docs
#
# == Examples
#
#     class { "mcollective::server": }
#
class mcollective::server (

  $package_version      = $mcollective::params::package_version,
  $service_name         = $mcollective::params::service_name,
  $config_file          = $mcollective::params::server_config_file,
  $config_owner         = $mcollective::params::client_config_owner,
  $config_group         = $mcollective::params::client_config_group,
  $mc_topic_prefix      = $mcollective::params::mc_topic_prefix,
  $mc_libdir            = $mcollective::params::mc_libdir,
  $mc_loglevel          = $mcollective::params::mc_loglevel,
  $mc_logfile           = $mcollective::params::mc_logfile,
  $mc_daemonize         = $mcollective::params::mc_daemonize,
  $mc_security_provider = $mcollective::params::mc_security_provider,
  $mc_security_psk      = $mcollective::params::mc_security_psk,
  $server_config_owner  = $mcollective::params::server_config_owner,
  $server_config_group  = $mcollective::params::server_config_group,
  $policy_dir           = $mcollective::params::policy_dir,
  $mc_service_name      = $mcollective::params::mc_service_name,
  $stomp_server         = $mcollective::params::stomp_server,
  $stomp_port           = $mcollective::params::stomp_port,
  $stomp_user           = $mcollective::params::stomp_user,
  $stomp_password       = $mcollective::params::stomp_password,
  $stomp_ssl            = $mcollective::params::stomp_ssl,
  $server_ssl_server_private = $mcollective::params::server_ssl_server_private,
  $server_ssl_server_public = $mcollective::params::server_ssl_server_public,
  $server_ssl_client_cert_dir = $mcollective::params::server_ssl_client_cert_dir,
  $nrpe_dir             = $mcollective::params::nrpe_dir,
  $fact_source          = $mcollective::params::fact_source,
  $yaml_facter_source   = $mcollective::params::yaml_facter_source

) inherits mcollective::params {

  anchor { "mcollective::server::begin": }~>
  class { 'mcollective::server::package': }~>
  class { 'mcollective::server::config': }~>
  class { 'mcollective::server::service': }~>
  anchor { "mcollective::server::end": }
}

