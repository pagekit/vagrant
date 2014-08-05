# Enable XDebug ("0" | "1")
$use_xdebug = "0"

# set default $PATH for all execs
# http://www.puppetcookbook.com/posts/set-global-exec-path.html
Exec
{
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

# update package manager
exec
{
    'apt-get update':
        command => '/usr/bin/apt-get update',
        require => Exec['add php55 apt-repo']
}

include first
include php55 # specific setup steps for 5.5
include php
include apache
include nginx
include mysql
include phpmyadmin
include composer
include varnish
include scripts

include pagekit