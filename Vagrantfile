# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.define :pagekit do |pka_config|

        # select box
        pka_config.vm.box = "hashicorp/precise32"
        pka_config.ssh.forward_agent = true

        # define static IP, uncomment to enable
        pka_config.vm.network :private_network, ip: "192.168.56.101"

        # define port-forwarding
        # pka_config.vm.network :forwarded_port, guest: 8000, host: 80, auto_correct: true
        # pka_config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true
        # pka_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true

        # hostname
        pka_config.vm.hostname = "pagekit"
        pka_config.vm.synced_folder "www", "/var/www", { :mount_options => ['dmode=777','fmode=777'] }
        pka_config.vm.provision :shell, :inline => "echo \"Europe/Berlin\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        # options for VirtualBox
        pka_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--memory", "512"]
        end

        # init puppet
        pka_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end
    end

end