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
    command => "/usr/bin/openssl genrsa -out ${mcdir}/${name}-private.pem",
    creates => "${mcdir}/${name}-private.pem",
  }

  file { "${mcdir}/${name}-private.pem":
    ensure  => "present",
    mode    => 0600,
    owner   => $name,
    require => Exec["genprivkey"],
  }

  exec { "genpubkey":
    command => "/usr/bin/openssl rsa -in ${mcdir}/${name}-private.pem -out ${mcdir}/${name}.pem -outform PEM -pubout",
    creates => "${mcdir}/${name}.pem",
    require => File["${mcdir}/${name}-private.pem"],
  }
}
