node[:deploy].each do |application, deploy|

  Chef::Log.info("Make sure you've included 'whenever' gem and schedule.rb has configged.")

  Chef::Log.info("Setting up corn job for #{application}...")

  stack_name = node[:opsworks][:stack][:name]

  Chef::Log.debug("Executing command:  bundle exec whenever --update-crontab '#{stack_name}_#{deploy[:rails_env]}' in dir: #{File.join(deploy[:deploy_to], 'current')}")

  execute "rake whenever to update crontab" do
    user node[:deploy][application][:user]
    cwd "#{File.join(deploy[:deploy_to], 'current')}"
    command "bundle exec whenever --update-crontab '#{stack_name}_#{deploy[:rails_env]}'"
    action :run
  end

  Chef::Log.info("Crontable has been updated successfully!")
end
