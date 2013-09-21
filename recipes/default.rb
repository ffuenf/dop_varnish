#
# Cookbook Name:: dop_varnish
# Recipe:: default
#

include_recipe "varnish::apt_repo"
include_recipe "varnish"

# create secret file
file node['varnish']['secret_file'] do
  content node['varnish']['secret']
  mode 0400
  action :create
end

# varnish config
template "#{node['varnish']['dir']}/default.vcl" do
  owner "root"
  group "root"
  mode 0644
  source "default.vcl.erb"
  variables({
    :params => node
  })
  action :create
end
# create directory for varnish configs
directory "#{node['varnish']['dir']}/vcl.d/" do
  action :create
end
# create include file for varnish
file "#{node['varnish']['dir']}/.all_includes.vcl" do
  content ""
  mode 0644
  action :create_if_missing
end
# varnish include script
cookbook_file "#{node['varnish']['dir']}/include_varnish_configs" do
  source "include_varnish_configs"
  mode 0755
  owner "root"
  group "root"
  action :create_if_missing
end
# redis optimization: http://www.fabrizio-branca.de/redis-optimization.html
execute "overcommit_memory" do
  command "echo 1 > /proc/sys/vm/overcommit_memory"
  action :run
end

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end