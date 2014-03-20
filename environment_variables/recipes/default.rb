Chef::Log.info("Running evrionment variables")

node[:deploy].each do |application, deploy|

  if node[:env]

    Chef::Log.info("Env variables set")

    directory "#{deploy[:deploy_to]}/shared/config" do
      owner "deploy"
      group "www-data"
      mode 0774
      recursive true
      action :create
    end

    env_vars_content = '# generated file do not edit'
    env_vars_content = env_vars_content + "\n\n"
    node[:env].each_pair do |env_var, var_val|
      unless env_var == 'PORT' || env_var == 'RACK_ENV'
        env_vars_content = env_vars_content + "\nENV['#{env_var}'] = '#{var_val}'"
      end
    end

    file File.join(deploy[:deploy_to], 'shared', 'config', 'environment_variables.rb') do
      content env_vars_content
    end

    Chef::Log.info("Env variables written")

  else

    Chef::Log.info("Env variables not set")

  end

end