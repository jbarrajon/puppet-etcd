# == Class etcd::install
#
class etcd::install inherits ::etcd {

  case $::etcd::install_method {
    'archive': {
      $archive_name = "etcd-v${::etcd::archive_version}-${::etcd::os_release}-${::etcd::release_arch}"
      $archive_url = "https://github.com/coreos/etcd/releases/download/v${::etcd::archive_version}/${archive_name}.${::etcd::release_ext}"
      file { "${::etcd::archive_path}/etcd":
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      } ->
      archive { "${archive_name}.${::etcd::release_ext}":
        path         => "/tmp/${archive_name}.${::etcd::release_ext}",
        source       => $archive_url,
        extract      => true,
        extract_path => "${::etcd::archive_path}/etcd",
        creates      => "${::etcd::archive_path}/etcd/${archive_name}/etcd",
        cleanup      => true,
      } ->
      file { "${::etcd::bin_path}/etcd":
        ensure => 'present',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => "${::etcd::archive_path}/etcd/${archive_name}/etcd",
      } ->
      file { "${::etcd::bin_path}/etcdctl":
        ensure => 'present',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => "${::etcd::archive_path}/etcd/${archive_name}/etcdctl",
      }

      if $::etcd::manage_user {
        user { $::etcd::user:
          ensure => 'present',
          system => true,
        }
        if $::etcd::manage_group {
          Group[$::etcd::group] -> User[$::etcd::user]
        }
      }
      if $::etcd::manage_group {
        group { $::etcd::group:
          ensure => 'present',
          system => true,
        }
      }

      file { '/etc/etcd':
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }
      file { '/var/lib/etcd':
        ensure => 'directory',
        owner  => $::etcd::user,
        group  => $::etcd::group,
        mode   => '0755',
      }
    }
    'repo': {
      package { 'etcd':
        ensure => $::etcd::package_ensure,
        name   => $::etcd::package_name,
      }
    }
    default: {
      fail("Installation method ${::etcd::install_method} not supported")
    }
  }

}
