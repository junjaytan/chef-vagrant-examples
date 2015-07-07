
# This will install postgres 9.3 and the auto_explain module
# see: # see: http://www.postgresql.org/download/linux/ubuntu/
apt_package ['postgresql-9.3', 'postgresql-contrib-9.3'] do
  action :install
end

# Initialize users, db, and schemas required for tamr default settings (drops added to make this idempotent)
execute 'DROP doit database if exists' do
  command 'psql -c "DROP DATABASE IF EXISTS doit;"'
  user 'postgres'
end

execute 'drop tamr role if exists' do
  command 'psql -c "DROP USER IF EXISTS tamr;"'
  user 'postgres'
end

execute 'create tamr role' do
  command 'psql -c "CREATE USER tamr SUPERUSER PASSWORD \'12345\';"'
  user 'postgres'
end

execute 'create doit database' do
  command 'psql -c "CREATE DATABASE doit WITH OWNER tamr;"'
  user 'postgres'
end


execute 'create tamr schema' do
  command 'psql -d doit -c "CREATE SCHEMA tamr AUTHORIZATION tamr;"'
  user 'postgres'
end

execute 'create staging schema' do
  command 'psql -d doit -c "CREATE SCHEMA staging AUTHORIZATION tamr;"'
  user 'postgres'
end

# need to add tamr.conf settings (called sandbox_postgres.conf)
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
    
    # otherwise insert a new line with variable
    fe.insert_line_if_no_match("^include = \'#{sandbox_conf_filename}\'", "include = \'#{sandbox_conf_filename}\'")
    fe.write_file
  
  end
end

# listen to all available ports
ruby_block "edit postgres.conf to listen to all ports" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/postgresql/9.3/main/postgresql.conf")
    
    # otherwise insert a new line with variable
    fe.insert_line_if_no_match("^listen_addresses = \'*\'", "listen_addresses = \'*\'")
    fe.write_file
  
  end
end

# allow access to postgres from external hosts
ruby_block "edit pg_hba.conf to allow access from external hosts" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/postgresql/9.3/main/pg_hba.conf")
    
    # otherwise insert a new line with variable
    fe.insert_line_if_no_match("^host all all 0.0.0.0/0 trust", "host all all 0.0.0.0/0 trust")
    fe.write_file
  
  end
end



service "postgresql" do
  action :restart
end

