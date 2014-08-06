class scripts {
  file { '/home/vagrant/scripts':
      source => 'puppet:///modules/scripts',
      recurse => true,
      owner    => vagrant,
      group    => vagrant,
      mode     => 0755,
    }
   
    package { 'inotify-tools':
        ensure => 'present',
        require => Exec['apt-get update'],
    }
   
    exec { 'generate gzip assets': 
      command => '/home/vagrant/scripts/gzip_static/notify-init.sh',
      refresh   => 'sudo pkill -9 -f "/home/vagrant/scripts/gzip_static/notify-init.sh" && /home/vagrant/scripts/gzip_static/notify-init.sh &',
      require => File['/home/vagrant/scripts'],
      user    => vagrant
    }
    
    exec { 'edit gzip watcher':
      command   => 'nohup /home/vagrant/scripts/gzip_static/notify-edit.sh &',
      refresh   => 'sudo pkill -9 -f "/home/vagrant/scripts/gzip_static/notify-edit.sh" && nohup /home/vagrant/scripts/gzip_static/notify-edit.sh &',
      unless    => "/bin/ps -ef | grep -v grep | /bin/grep '/home/vagrant/scripts/gzip_static/notify-edit.sh'",
    }
    
    exec { 'delete gzip watcher':
      command   => 'nohup /home/vagrant/scripts/gzip_static/notify-delete.sh &',
      refresh   => 'sudo pkill -9 -f "/home/vagrant/scripts/gzip_static/notify-delete.sh" && nohup /home/vagrant/scripts/gzip_static/notify-delete.sh &',
      unless    => "/bin/ps -ef | grep -v grep | /bin/grep '/home/vagrant/scripts/gzip_static/notify-delete.sh'",
    }
}