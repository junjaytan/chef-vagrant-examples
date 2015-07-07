execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

# This will install tomcat in /etc/tomcat7
apt_package ['tomcat7', 'tomcat7-admin'] do
  action :install
end

# set JAVA_HOME to point to oracle 8 jdk


# The below commands set tomcat7 to start on startup
execute 'remove any tomcat7 bootup symbolic links' do
  command 'sudo update-rc.d -f tomcat7 remove'
end

execute 'set tomcat7 to launch at boot' do
  command 'sudo update-rc.d tomcat7 defaults'
end

# in the future, might be worth having all tomcat7 processes/files run by tomcat7 user
# for now, it runs as root via sudo service tomcat7 start
# see: http://askubuntu.com/questions/371809/run-tomcat7-as-tomcat7-or-any-other-user

# Set webapps directory and subdirectories to be owned by tomcat7 user/group
directory '/var/lib/tomcat7/webapps' do
  owner 'tomcat7'
  group 'tomcat7'
  #mode '0755'
  recursive true
  action :create
end


