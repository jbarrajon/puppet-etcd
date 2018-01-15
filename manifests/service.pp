# == Class etcd::service
#
class etcd::service inherits ::etcd {

  if $::etcd::manage_service {
    service { 'etcd':
      ensure   => $::etcd::service_ensure,
      enable   => $::etcd::service_enable,
      name     => $::etcd::service_name,
      provider => $::etcd::service_provider,
    }
  }

}
