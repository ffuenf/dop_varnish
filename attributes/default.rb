# # # # # #
# default #
# # # # # #

default['varnish']['url'] = 'https://repo.varnish-cache.org/pkg/5.0.0/varnish_5.0.0-1_amd64.deb'
default['varnish']['version'] = '4.0'
default['varnish']['instance'] = 'main'
default['varnish']['storage'] = 'file'
default['varnish']['storage_dir'] = "/var/lib/varnish/#{node['varnish']['instance']}"
default['varnish']['storage_file'] = "#{node['varnish']['storage_dir']}/varnish_storage.bin"
default['varnish']['file_storage_size'] = '1G'
default['varnish']['vcl_cookbook'] = 'dop_varnish'
default['varnish']['conf_cookbook'] = 'dop_varnish'

default['varnish']['parameters']['vcc_allow_inline_c'] = 'on'
default['varnish']['parameters']['esi_syntax'] = '0x2'
default['varnish']['parameters']['syslog_cli_traffic'] = 'off'
default['varnish']['parameters']['cli_buffer'] = '16384'
default['varnish']['parameters']['feature'] = '+esi_ignore_other_elements'

default['varnish']['listen_address'] = '127.0.0.1'
default['varnish']['admin_listen_port'] = 6_082
default['varnish']['ttl'] = 120
