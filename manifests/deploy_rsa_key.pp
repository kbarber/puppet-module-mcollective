# This defined resource deploys an rsa key that was previously created
# by create_rsa_key.
#
# This is generally ran on the mcollective servers.
#
# == Parameters
#
# [*namevar*]
#   Username of the key owner.
# 
# == Examples
#
#     mcollective::deploy_rsa_key { "ken": }
#
define mcollective::deploy_rsa_key {
  $pubkeypath = "/etc/mcollective/pubkeys/"

  file { "${mcollective::server::server_ssl_client_cert_dir}/${name}.pem":
    content => file("${pubkeypath}/${name}.pem", "/dev/null"),
    require => Class["mcollective::server::config"],
  }
}
