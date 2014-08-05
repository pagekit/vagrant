class scripts {
  file { '/home/vagrant/scripts':
      source => 'puppet:///modules/scripts',
      recurse => true,
      owner    => vagrant,
      group    => vagrant,
      mode     => 0755,
    }
   
   
    exec { 'generate the gz assets': 
      command => '/home/vagrant/scripts/gzip_static/notify-init.sh',
      require => File['/home/vagrant/scripts'],
      user    => vagrant
    }
}