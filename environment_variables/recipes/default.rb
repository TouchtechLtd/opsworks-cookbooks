Chef::Log.info("Running evrionment variables")

node[:deploy].each do |application, deploy|

  if node[:env]

    Chef::Log.info("Env variables set")

    env_dir_path = "#{deploy[:deploy_to]}/shared/config"
    Chef::Log.info("Creating enclosing directory #{env_dir_path} if it doesn't exist")
    directory env_dir_path do
      owner node[:deploy][application][:user]
      group node[:deploy][application][:group]
      mode 0770
      recursive true
      action :create
    end

    env_file_path = "#{deploy[:deploy_to]}/shared/config/environment_variables.rb"
    Chef::Log.info("Writing variables to #{env_file_path}")
    template env_file_path do
      cookbook 'environment_variables'
      source 'environment_variables.rb.erb'
      owner node[:deploy][application][:user]
      group node[:deploy][application][:group]
      mode 0660
      variables(
        :env => node[:env]
      )
    end.run_action(:create)

    Chef::Log.info("Env variables written")

  else

    Chef::Log.info("Env variables not set")

  end

end