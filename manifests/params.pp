# == Class etcd::params
#
class etcd::params {

  $install_method = 'archive'

  $package_name   = 'etcd'
  $package_ensure = 'latest'

  $archive_path    = '/opt'
  $archive_version = '3.0.17'
  $bin_path        = '/usr/bin'
  $os_release      = 'linux'
  $release_arch    = 'amd64'
  $release_ext     = 'tar.gz'
  $manage_user     = true
  $manage_group    = true
  $user            = 'etcd'
  $group           = 'etcd'

  $manage_service_file = true

  $manage_service   = true
  $service_name     = 'etcd'
  $service_enable   = true
  $service_ensure   = 'running'
  $service_provider = 'systemd'

  $config_options = {
    'member' => {
      'ETCD_NAME' => 'default',
      'ETCD_DATA_DIR' => '/var/lib/etcd/default.etcd',
      'ETCD_LISTEN_CLIENT_URLS' => 'http://localhost:2379',
    },
    'cluster' => {
      'ETCD_ADVERTISE_CLIENT_URLS' => 'http://localhost:2379',
    }
  }

}
