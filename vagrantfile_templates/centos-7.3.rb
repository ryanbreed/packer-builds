Vagrant.require_version '>= 1.9.1'

Vagrant.configure("2") do |config|
  config.vm.box = "centos"
  config.vm.hostname = "vm-test"
  config.vm.network :public_network,
    dev: "lanbr0",
    type: "bridge",
    mode: "bridge",
    model_type: "virtio"
  config.vm.provider :libvirt do |libvirt|
    libvirt.storage_pool_name = "vagrant"
    libvirt.volume_cache = "unsafe"
    libvirt.driver = "kvm"
    libvirt.memory = 1024
    libvirt.cpus = 4
    libvirt.default_prefix = "vagrant"
    libvirt.channel :type => 'unix',
                    :target_name => 'org.qemu.guest_agent.0',
                    :target_type => 'virtio'

  end
end
