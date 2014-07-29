# Pagekit Vagrant

A Vagrant setup for Pagekit with PHP 5.5 and Apache 2.4 / nginx 1.1.19 on a Ubuntu 12.04 machine.


## Requirements

- [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant 1.3+](http://www.vagrantup.com/downloads.html)
- [Git](http://git-scm.com/downloads)


## Get started

- Clone this repository `git clone insert-link-here`
- Run `vagrant up` in this repository
    + this may take some time, as the first time you run Vagrant, it might need to fetch the VM, the pagekit repository and all additional packages, that are required for pagekit.
- Navigate your browser to `http://192.168.56.101/`
- Pagekit will welcome you with its installation guide


## Usage

### IP-Address & Ports

By default, port-forwarding is not activated, but you can access the VM via the IP-Address `192.168.56.101`. Some usefull addresses to get startet:

- `http://192.168.56.101/` loads pagekit using **apache**
- `http://192.168.56.101:8080/` loads pagekit using **nginx**
- `http://192.168.56.101/phpmyadmin` - PHPmyAdmin

You can activate port-forwarding by modifying lines 16-19 in the vagrant file.

### MySQL

- User: root
- Password: _empty_


## Virtual Machine Specifications

- OS: 32-bit Ubuntu 12.04 LTS
- Apache 2.4.6
- nginx 1.1.19
- PHP 5.5.4
- MySQL 5.5.32


#### Credits

The puppet modules are based on the [laravel4-vagrant](https://github.com/bryannielsen/Laravel4-Vagrant) setup.
