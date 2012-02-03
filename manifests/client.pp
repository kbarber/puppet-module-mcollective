# This class installs the MCollective client component for your nodes
#
# == Parameters
#
# [*config*]
#   *Optional* The content of the MCollective client configuration file.
# [*package_version*]
#   *Optional* The version of the MCollective package(s) to be installed.
# [*config_file*]
#   *Optional* The full path to the MCollective client configuration file.
# [*config_owner*]
#   *Optional* Owner of the configuration file.
# [*config_group*]
#   *Optional* Group of the configuration file.
#
# == Examples
#
#     class { "mcollective::client": }
#
class mcollective::client (

  $package_version = $mcollective::params::package_version,
  $config_file     = $mcollective::params::client_config_file,
  $config_owner    = $mcollective::params::client_config_owner,
  $config_group    = $mcollective::params::client_config_group,
  $mc_topic_prefix = $mcollective::params::mc_topic_prefix,
  $mc_libdir       = $mcollective::params::mc_libdir,
  $mc_loglevel     = $mcollective::params::mc_loglevel,
  $mc_security_provider = $mcollective::params::mc_security_provider,
  $mc_security_psk = $mcollective::params::mc_security_psk,
  $client_ssl_server_public = $mcollective::params::client_ssl_server_public,
  $client_ssl_client_private = $mcollective::params::client_ssl_client_private,
  $client_ssl_client_public = $mcollective::params::client_ssl_client_public,
  $stomp_server    = $mcollective::params::stomp_server,
  $stomp_port      = $mcollective::params::stomp_port,
  $stomp_user      = $mcollective::params::stomp_user,
  $stomp_password  = $mcollective::params::stomp_password,
  $stomp_ssl       = $mcollective::params::stomp_ssl

) inherits mcollective::params {

  anchor { "mcollective::client::begin": }~>
  class { 'mcollective::client::package': }~>
  class { 'mcollective::client::config': }~>
  anchor { "mcollective::client::end": }

}
