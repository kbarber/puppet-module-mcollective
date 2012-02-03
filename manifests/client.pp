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
  $config          = $mcollective::params::client_config,
  $config_file     = $mcollective::params::client_config_file,
  $config_owner    = $mcollective::params::client_config_owner,
  $config_group    = $mcollective::params::client_config_group

) inherits mcollective::params {

  anchor { "mcollective::client::begin": }~>
  class { 'mcollective::client::package': }~>
  class { 'mcollective::client::config': }~>
  anchor { "mcollective::client::end": }

}
