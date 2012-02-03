class mcollective::server::service(

  $mc_service_name     = $mcollective::server::mc_service_name,

) {

  service { 'mcollective':
    ensure    => running,
    enable    => true,
    name      => $mc_service_name,
    hasstatus => true,
  }

  cron { "facter_cache":
    command => "facter -y > /etc/mcollective/facts.yaml.tmp ; mv -f /etc/mcollective/facts.yaml.tmp /etc/mcollective/facts.yaml",
    minute => "*/15",
  }
}
