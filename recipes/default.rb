#
# Cookbook Name:: dop_varnish
# Recipe:: default
#

include_recipe 'varnish::repo'
package 'varnish'

directory node['varnish']['storage_dir'] do
  recursive true
end
directory node['varnish']['dir']

# create secret file
file node['varnish']['secret_file'] do
  content node['varnish']['secret']
  mode 0400
  action :create
end

# create directory for varnish configs
directory "#{node['varnish']['dir']}/vcl.d/" do
  action :create
end
# create include file for varnish
file "#{node['varnish']['dir']}/.all_includes.vcl" do
  content ''
  mode 0644
  action :create_if_missing
end
# varnish include script
cookbook_file "#{node['varnish']['dir']}/include_varnish_configs" do
  source 'include_varnish_configs'
  cookbook 'dop_varnish'
  mode 0755
  owner 'root'
  group 'root'
  action :create_if_missing
end

# redis optimization: http://www.fabrizio-branca.de/redis-optimization.html
execute 'overcommit_memory' do
  command 'echo 1 > /proc/sys/vm/overcommit_memory'
  action :run
end

# create directory for varnish storage_dir
directory "#{node['varnish']['storage_dir']}/" do
  action :create
end

# varnish config
varnish_default_config 'main' do
  start_on_boot true
  listen_address node['varnish']['listen_address']
  listen_port node['varnish']['listen_port']
  path_to_vcl "#{node['varnish']['dir']}/default.vcl"
  admin_listen_address node['varnish']['listen_address']
  admin_listen_port node['varnish']['admin_listen_port']
  user node['varnish']['user']
  group node['varnish']['group']
  ttl node['varnish']['ttl']
  storage node['varnish']['storage']
  file_storage_path node['varnish']['storage_file']
  file_storage_size node['varnish']['file_storage_size']
  parameters(
    thread_pools: node['varnish']['parameters']['thread_pools'],
    thread_pool_min: node['varnish']['parameters']['thread_pool_min'],
    thread_pool_max: node['varnish']['parameters']['thread_pool_max'],
    thread_pool_timeout: node['varnish']['parameters']['thread_pool_timeout'],
    cli_buffer: node['varnish']['parameters']['cli_buffer'],
    syslog_cli_traffic: node['varnish']['parameters']['syslog_cli_traffic'],
    feature: node['varnish']['parameters']['feature'],
    vcc_allow_inline_c: node['varnish']['parameters']['vcc_allow_inline_c']
  )
  path_to_secret node['varnish']['secret_file']
end

varnish_install 'main' do
  package_name 'varnish'
  vendor_repo true
  vendor_version node['varnish']['version']
end

execute 'varnish-systemd-reload' do
  command 'systemctl daemon-reload'
  action :nothing
  subscribes :run, "file[#{node['varnish']['dir']}/default.vcl]", :immediately
end
