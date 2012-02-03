# Setup an actionpolicy
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
