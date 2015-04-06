Vagrant.configure('2') do |config|
  # vagrant-omnibus
  if Vagrant.has_plugin?('vagrant-omnibus')
    config.omnibus.chef_version = :latest
    config.omnibus.cache_packages = true
  end

  # vagrant-berkshelf
  config.berkshelf.enabled = true if Vagrant.has_plugin?('vagrant-berkshelf')

  # vagrant-cachier
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  # network
  config.vm.network 'private_network', ip: '10.0.0.50'

  # basebox
  config.vm.box = 'ffuenf/debian-7.8.0-amd64'

  # virtualbox options
  config.vm.provider 'virtualbox' do |v|
    v.gui = false
    v.customize ['modifyvm', :id, '--memory', 2048]
    v.customize ['modifyvm', :id, '--cpus', 2]
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  config.vm.provider 'digital_ocean' do |provider, override|
    override.ssh.private_key_path = ENV['DIGITALOCEAN_SSH_KEY_PATH']
    override.ssh.username = 'root'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
    provider.token = ENV['DIGITALOCEAN_ACCESS_TOKEN']
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'ams3'
    provider.size = '512mb'
    provider.ipv6 = true
  end

  # Configure Chef Solo provisioner
  config.vm.provision 'chef_zero' do |chef|
    chef.provisioning_path = '/tmp/vagrant-chef-solo'
    chef.file_cache_path = chef.provisioning_path
    chef.cookbooks_path = ['.chef/cookbooks']
    chef.add_recipe 'dop_varnish'
    chef.json = {}
  end
end
