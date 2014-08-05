class varnish (
  $start                        = 'yes',
  $nfiles                       = '131072',
  $memlock                      = '82000',
  $storage_type                 = 'malloc',
  $varnish_vcl_conf             = '/etc/varnish/pagekit.vcl',
  $varnish_listen_address       = '',
  $varnish_listen_port          = '6080',
  $varnish_admin_listen_address = '127.0.0.1',
  $varnish_admin_listen_port    = '6079',
  $varnish_min_threads          = '5',
  $varnish_max_threads          = '500',
  $varnish_thread_timeout       = '300',
  $varnish_storage_size         = '1G',
  $varnish_secret_file          = '/etc/varnish/secret',
  $varnish_storage_file         = '/var/lib/varnish-storage/varnish_storage.bin',
  $varnish_ttl                  = '120',
  $shmlog_dir                   = '/var/lib/varnish',
  $shmlog_tempfs                = true,
  $version                      = present,
  $probes     = [],
  $backends   = [ { name => 'default', host => '127.0.0.1', port => '8080' } ],
  $directors  = [],
  $acls       = [],
  $selectors  = [],
  $conditions = [],
) {

  package { 'varnish':
    ensure  => 'present',
  }

  service { 'varnish':
    ensure  => running,
    require => Package['varnish'],
  }

  # mount shared memory log dir as tempfs
  if $shmlog_tempfs {
    class { 'varnish::shmlog':
      shmlog_dir => $shmlog_dir,
      require => Package['varnish'],
    }
  }

  # varnish config file
  file { 'varnish-conf':
    ensure  => present,
    path    => '/etc/default/varnish',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('varnish/varnish-conf.erb'),
    require => Package['varnish'],
    notify  => Service['varnish'],
  }
  
    file { 'varnish-vcl':
        ensure  => present,
        path    => $varnish::varnish_vcl_conf,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('varnish/varnish-vcl.erb'),
        notify  => Service['varnish'],
        require => Package['varnish'],
    }

    $varnish_storage_dir = regsubst($varnish_storage_file, '(^/.*)(/.*$)', '\1')
    file { 'storage-dir':
        ensure  => directory,
        path    => $varnish_storage_dir,
        require => Package['varnish'],
    }
}