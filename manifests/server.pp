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

  $package_version     = $mcollective::params::package_version,
  # TODO
  $config              = "TODO",
  $service_name        = $mcollective::params::service_name,
  $config_file         = $mcollective::params::server_config_file,
  $server_config_owner = $mcollective::params::server_config_owner,
  $server_config_group = $mcollective::params::server_config_group,
  $policy_dir          = $mcollective::params::policy_dir,
  $mc_service_name     = $mcollective::params::mc_service_name

) inherits mcollective::params {

  anchor { "mcollective::server::begin": }~>
  class { 'mcollective::server::package': }~>
  class { 'mcollective::server::config': }~>
  class { 'mcollective::server::service': }~>
  anchor { "mcollective::server::end": }
}

