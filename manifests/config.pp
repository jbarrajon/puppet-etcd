# == Class etcd::config
#
class etcd::config inherits ::etcd {

  file { '/etc/etcd/etcd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('etcd/etcd.conf.erb'),
  }

  if $::etcd::manage_service_file {
    case $::etcd::service_provider {
      'systemd' : {
        file { '/lib/systemd/system/etcd.service':
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('etcd/etcd.systemd.erb'),
        }
      }
      default : {
        fail("etcd::service_provider '${::etcd::service_provider}' is not supported")
      }
    }
  }

}
