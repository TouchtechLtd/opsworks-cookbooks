node[:deploy].each do |application, deploy|

  Chef::Log.info("Make sure you've got whenever gem installed and schedule.rb configed.")
  Chef::Log.info("Setting up corn job for #{application}...")

  execute "rake whenever to write to crontab" do
    cwd "#{File.join(deploy[:deploy_to], 'current')}"
    command "bundle exec whenever"
  end

  Chef::Log.info("Crontable has been updated")

end
