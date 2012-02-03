class mcollective::server::service(

  $mc_service_name     = $mcollective::server::mc_service_name,
  $yaml_facter_source  = $mcollective::server::yaml_facter_source

) {

  service { 'mcollective':
    ensure    => running,
    enable    => true,
    name      => $mc_service_name,
    hasstatus => true,
  }

  cron { "facter_cache":
    command => "/usr/bin/facter -y > ${yaml_facter_source}.tmp ; mv -f ${yaml_facter_source}.tmp ${yaml_facter_source}",
    minute => "*/15",
  }
}
