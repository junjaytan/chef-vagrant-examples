file "/etc/postgresql/9.3/main/tamr_sandbox_postgres.conf" do
  owner 'tomcat7'
  group 'tomcat7'
  mode 0755
  content ::File.open("/vagrant/scripts/tamr_sandbox_postgres.conf").read
  action :create
end

sandbox_conf_filename='tamr_sandbox_postgres.conf'
# include link to this config file
ruby_block "edit postgres.conf to include tamr settings" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/postgresql/9.3/main/postgresql.conf")
    
    # insert a new line to include settings file if doesn't exist
    fe.insert_line_if_no_match("^include = \'#{sandbox_conf_filename}\'", "include = \'#{sandbox_conf_filename}\'")
    fe.write_file
  
  end
end

service "postgresql" do
  action :restart
end

