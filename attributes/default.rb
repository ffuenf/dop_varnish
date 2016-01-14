# # # # # #
# default #
# # # # # #
default['dop_varnish']['databag'] = Chef::EncryptedDataBagItem.load('dop_varnish', 'default')

default['varnish']['secret'] = node['dop_varnish']['databag']['secret']
default['varnish']['version'] = '4.0'
default['varnish']['instance'] = 'main'
default['varnish']['storage'] = 'file'
default['varnish']['storage_dir'] = "/var/lib/varnish/#{node['varnish']['instance']}"
default['varnish']['storage_file'] = "#{node['varnish']['storage_dir']}/varnish_storage.bin"
default['varnish']['vcl_cookbook'] = 'dop_varnish'

default['varnish']['parameters']['vcc_allow_inline_c'] = 'on'
default['varnish']['parameters']['esi_syntax'] = '0x2'
default['varnish']['parameters']['syslog_cli_traffic'] = 'off'
default['varnish']['parameters']['cli_buffer'] = '16384'
default['varnish']['parameters']['feature'] = '+esi_ignore_other_elements'

default['varnish']['listen_address'] = '127.0.0.1'
