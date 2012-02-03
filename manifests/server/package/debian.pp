# This class installs MCollective dependency packages for Debian.
class mcollective::server::package::debian {

  package { 'libstomp-ruby':
    ensure => present,
  }->
  package { 'mcollective':
    ensure  => $mcollective::server::package_version,
  }

}

