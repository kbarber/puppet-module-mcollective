# This class installs the MCollective configuration files.
#
# *Note:* This class is not to be invoked externally.
class mcollective::server::config(

  $config_file         = $mcollective::server::config_file,
  $server_config_owner = $mcollective::server::server_config_owner,
  $server_config_group = $mcollective::server::server_config_group,
  $policy_dir          = $mcollective::server::policy_dir

) {

  file { 'server_config':
    path    => $config_file,
    content => template("${module_name}/server.cfg.erb"),
    mode    => '0640',
    owner   => $server_config_owner,
    group   => $server_config_group,
    notify  => Class['mcollective::server::service'],
  }

  file { $policy_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  file { $server_ssl_client_cert_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => root,
    group   => root,
  }
}
