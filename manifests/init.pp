# == Class: etcd
#
# Installs, configures, and manages etcd
#
class etcd (
  $install_method      = $::etcd::params::install_method,
  $package_name        = $::etcd::params::package_name,
  $package_ensure      = $::etcd::params::package_ensure,
  $archive_path        = $::etcd::params::archive_path,
  $archive_version     = $::etcd::params::archive_version,
  $bin_path            = $::etcd::params::bin_path,
  $os_release          = $::etcd::params::os_release,
  $release_arch        = $::etcd::params::release_arch,
  $release_ext         = $::etcd::params::release_ext,
  $manage_user         = $::etcd::params::manage_user,
  $manage_group        = $::etcd::params::manage_group,
  $user                = $::etcd::params::user,
  $group               = $::etcd::params::group,
  $manage_service_file = $::etcd::params::manage_service_file,
  $manage_service      = $::etcd::params::manage_service,
  $service_name        = $::etcd::params::service_name,
  $service_enable      = $::etcd::params::service_enable,
  $service_ensure      = $::etcd::params::service_ensure,
  $service_provider    = $::etcd::params::service_provider,
  $config_options      = $::etcd::params::config_options,
) inherits ::etcd::params {

  $final_config_options = lookup('etcd::config_options', { 'value_type' => Hash, 'merge' => 'deep', 'default_value' => $config_options })

  include ::etcd::install
  include ::etcd::config
  include ::etcd::service

  Class['::etcd::install'] -> Class['::etcd::config']
  Class['::etcd::config'] ~> Class['::etcd::service']

}
