# This class installs the MCollective client configuration files.
#
# *Note:* This class should not be invoked externally.
class mcollective::client::config {

  file { $mcollective::client::config_file:
    content => $mcollective::client::config,
    mode    => 0600,
    owner   => $mcollective::client::config_owner,
    group   => $mcollective::client::config_group,
  }

}

