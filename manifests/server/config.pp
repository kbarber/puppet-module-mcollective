# This class installs the MCollective configuration files.
#
# *Note:* This class is not to be invoked externally.
class mcollective::server::config {

  file { $mcollective::server::config_file:
    content => template("${module_name}/server.cfg.erb"),
    mode    => '0640',
    owner   => $mcollective::server::server_config_owner,
    group   => $mcollective::server::server_config_group,
  }

  file { $mcollective::server::policy_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  file { $mcollective::server::server_ssl_client_cert_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => root,
    group   => root,
  }
}
