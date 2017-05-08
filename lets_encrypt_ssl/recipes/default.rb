include_recipe 'acme'

node['deploy'].each do |application, deploy|
    acme_certificate ENV['SSL_DOMAIN'] do
        fullchain         "/etc/ssl/#{application}.crt"
        key               "/etc/ssl/#{application}.key"
        wwwroot           "#{deploy[:deploy_to]}/current/public"
        notifies          :reload, 'service[nginx]'
    end
end