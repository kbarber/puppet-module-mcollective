# Generate an RSA key for a user.
#
# This is generally ran on the client.
#
# == Parameters
#
# [*namevar*]
#   The username of the key owner.
#
# == Examples
#
#     mcollective::create_rsa_key { "ken": }
#
define mcollective::create_rsa_key {
  $mcdir = "/home/${name}/.mc/"

  file { $mcdir:
    ensure => directory,
    owner  => $name,
  }

  # First generate private key
  exec { "genprivkey":
    command   => "/usr/bin/openssl genrsa -out ${mcdir}/${name}-private.pem",
    creates   => "${mcdir}/${name}-private.pem",
    logoutput => on_failure,
    require   => File[$mcdir],
  }

  file { "${mcdir}/${name}-private.pem":
    ensure  => "present",
    mode    => 0600,
    owner   => $name,
    require => Exec["genprivkey"],
  }

  $pubkeypath = "/etc/mcollective/pubkeys/"

  exec { "genpubkey":
    command   => "/usr/bin/openssl rsa -in ${mcdir}/${name}-private.pem -out ${pubkeypath}/${name}.pem -outform PEM -pubout",
    creates   => "${pubkeypath}/${name}.pem",
    require   => File["${mcdir}/${name}-private.pem"],
    logoutput => on_failure,
  }
  file { "${pubkeypath}/${name}.pem":
    ensure  => "present",
    mode    => "0644",
    owner   => "root",
    group   => "root",
    require => Exec["genpubkey"],
  }

  file { "${mcdir}/${name}.pem":
    source  => "${pubkeypath}/${name}.pem",
    mode    => 0600,
    owner   => $name,
    require => File["${pubkeypath}/${name}.pem"],
  }
}
