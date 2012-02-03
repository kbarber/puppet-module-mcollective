# This class installs the MCollective server package and all dependencies.
#
# *Note:* This class is not to be invoked externally.
class mcollective::server::package(
  $package_version = $mcollective::server::package_version
) {

  anchor { 'mcollective::server::package::begin': }
  anchor { 'mcollective::server::package::end': }
  Class {
    require => Anchor['mcollective::server::package::begin'],
    before  => Anchor['mcollective::server::package::end'],
  }

  case $operatingsystem {
    debian,ubuntu: {
      class { 'mcollective::server::package::debian': }
    }
    redhat,centos,oel: {
      class { 'mcollective::server::package::redhat': }
    }
    default: {
      fail("operatingsystem not supported: ${operatingsystem}")
    }
  }

}

