# This class installs MCollective dependency packages for Redhat.
class mcollective::server::package::redhat {
  package { 'mcollective': 
    ensure => $mcollective::server::package_version
  }
}

