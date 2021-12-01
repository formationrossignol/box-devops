Vagrant.configure(2) do |config|

	config.vm.define "devOpsBox" do |devOpsBox|

		devOpsBox.vm.box = "rockylinux/8"
		devOpsBox.vm.box_version = "4.0.0"
    devOpsBox.vm.network "private_network", ip: "192.168.1.120"
    devOpsBox.vm.hostname = "devOpsBox"
    devOpsBox.vm.provision "shell", path: "scripts/install.sh"
    		
    devOpsBox.vm.provider "virtualbox" do |v|
      v.memory = 4096
    	v.cpus = 2
    end

	end
end

