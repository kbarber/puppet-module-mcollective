# This class installs the MCollective client package and all dependencies
#
# *Note*: This class generally shouldn't be i externally.
class mcollective::client::package {
  package { 'mcollective-client':
    ensure	  => $mcollective::client::package_version,
  }
}

