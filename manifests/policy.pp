# Setup an actionpolicy - this is normally ran on the mcollective
# server.
#
# == Parameters
#
# [*userpolicy*]
#   Hash containing the user policy.
#
# == Examples
#
#     mcollective::policy { "package":
#       userpolicy => {
#         'ken' => {
#           'policy' => 'allow',
#           'actions' => ['status'],
#         },
#       }
#     }
#
define mcollective::policy (
  $userpolicy
) {

  file { "/etc/mcollective/policies/${name}.policy":
    content => template("${module_name}/policy.erb"),
    owner   => root,
    group   => root,
    require => Package["mcollective::server::config"],
  }

}
