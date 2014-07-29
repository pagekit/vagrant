class pagekit
{

    package { 'git-core':
        ensure => present,
    }


    # Check to see if there's a composer.json and app directory before we delete everything
    # We need to clean the directory in case a .DS_STORE file or other junk pops up before
    # the composer create-project is called
    exec { 'clean www directory':
        command => "/bin/sh -c 'cd /var/www && find -mindepth 1 -delete'",
        unless => [ "test -f /var/www/pagekit.php" ],
        require => Package['apache2']
    }


    # Clone the Pagekit Git repository
    exec { 'clone pagekit':
        command => "/bin/sh -c 'cd /var/www && git clone https://github.com/pagekit/pagekit.git .'",
        require => [ Package['git-core'], Exec['clean www directory'] ],
        unless => [ "test -f /var/www/pagekit.php" ],
        timeout => 900,
        logoutput => true
    }

    # Install packages using composer
    exec { 'install packages':
        command => "/bin/sh -c 'cd /var/www && composer install'",
        require => [ Package['git-core'], Exec['global composer'], Exec['clone pagekit'] ],
        onlyif => [ "test -f /var/www/composer.json" ],
        timeout => 900,
        logoutput => true
    }

    # Update packages using composer
    exec { 'update packages':
        command => "/bin/sh -c 'cd /var/www && composer install'",
        require => [ Package['git-core'], Exec['global composer'], Exec['clone pagekit'], Exec['install packages'] ],
        onlyif => [ "test -f /var/www/composer.json" ],
        timeout => 900,
        logoutput => true
    }

    # file { '/var/www/storage':
    #     mode => 0777
    # }


}
