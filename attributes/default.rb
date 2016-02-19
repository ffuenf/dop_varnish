# # # # # #
# default #
# # # # # #

default['varnish']['version'] = '4.0'
default['varnish']['instance'] = 'default'
default['varnish']['storage'] = 'file'
default['varnish']['storage_dir'] = "/var/lib/varnish/#{node['varnish']['instance']}"
default['varnish']['storage_file'] = "#{node['varnish']['storage_dir']}/varnish_storage.bin"
default['varnish']['storage_size'] = '1g'
default['varnish']['cli_buffer'] = 16_384
default['varnish']['syslog_cli_traffic'] = 'off'
default['varnish']['vcc_allow_inline_c'] = 'on'
default['varnish']['esi_syntax'] = '0x2'

default['varnish']['listen_address'] = '127.0.0.1'

default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = '8080'
