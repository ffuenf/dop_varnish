# # # # # #
# default #
# # # # # #
default['dop_varnish']['databag'] = Chef::EncryptedDataBagItem.load('dop_varnish', 'default')

default['varnish']['secret'] = node['dop_varnish']['databag']['secret']
default['varnish']['version'] = '4.0'
default['varnish']['instance'] = 'default'
default['varnish']['storage'] = 'file'
default['varnish']['storage_file'] = '/var/lib/varnish/$INSTANCE/varnish_storage.bin'
default['varnish']['storage_size'] = '1g'

default['varnish']['listen_address'] = '127.0.0.1'

default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = '8080'
