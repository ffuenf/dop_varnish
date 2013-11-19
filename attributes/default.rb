# # # # # #
# default #
# # # # # #
default['dop_varnish']['databag'] = Chef::EncryptedDataBagItem.load("dop_varnish", "default")

default['varnish']['secret'] = node['dop_varnish']['databag']['secret']
default['varnish']['version'] = "3.0"
default['varnish']['instance'] = node['dop_base']['hosts']['hostname']

default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = '8080'
