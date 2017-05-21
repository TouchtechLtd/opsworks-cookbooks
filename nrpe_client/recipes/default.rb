#
# Cookbook:: nrpe_client
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/etc/nagios' do
  owner 'root'
  group 'root'
  mode '0775'
  action :create
end

template '/etc/nagios/nrpe.cfg' do
  source 'nrpe.cfg'
  owner 'root'
  group 'root'
  mode '0644'
  variables allowed_hosts: node['nrpe_client']['allowed_hosts'], commands_list: node['nrpe_client']['commands_list']
  source "nrpe.cfg.erb"
end

service "nrpe" do
  action [:enable, :start]
end 