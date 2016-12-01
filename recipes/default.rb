#
# Cookbook Name:: dop_varnish
# Recipe:: default
#

if node['varnish']['version'] != '5.0'
  include_recipe 'varnish::repo'
  package 'varnish'
else
  package 'libjemalloc1'
  varnish_src_filepath = "#{Chef::Config['file_cache_path']}/varnish-#{node['varnish']['version']}.deb"
  unless ::File.exist?(varnish_src_filepath)
    remote_file varnish_src_filepath do
      source node['varnish']['url']
    end
    bash 'install varnish' do
      cwd ::File.dirname(varnish_src_filepath)
      code <<-EOH
          dpkg -i #{varnish_src_filepath}
      EOH
    end
  end
end

directory node['varnish']['storage_dir'] do
  recursive true
end
directory node['varnish']['dir']

# create secret file
file node['varnish']['secret_file'] do
  content node['varnish']['secret']
  mode 0o400
  action :create
end

# create directory for varnish configs
directory "#{node['varnish']['dir']}/vcl.d/" do
  action :create
end
# create include file for varnish
file "#{node['varnish']['dir']}/.all_includes.vcl" do
  content ''
  mode 0o644
  action :create_if_missing
end
# varnish include script
cookbook_file "#{node['varnish']['dir']}/include_varnish_configs" do
  source 'include_varnish_configs'
  cookbook 'dop_varnish'
  mode 0o755
  owner 'root'
  group 'root'
  action :create_if_missing
end

execute 'overcommit_memory' do
  command 'echo 1 > /proc/sys/vm/overcommit_memory'
  action :run
end

# create directory for varnish storage_dir
directory "#{node['varnish']['storage_dir']}/" do
  action :create
end

# varnish config
template '/etc/default/varnish' do
  source 'default.erb'
  cookbook 'dop_varnish'
  owner 'root'
  group 'root'
  mode 0o644
  variables(
    varnish: node['varnish']
  )
  notifies 'restart', 'service[varnish]', :delayed
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
