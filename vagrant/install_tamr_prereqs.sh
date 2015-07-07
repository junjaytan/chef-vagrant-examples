# update apt-get
sudo apt-get update

# install chef local
curl -L https://www.chef.io/chef/install.sh | sudo bash

# install bundler and serverspec
sudo gem install bundler
sudo gem install serverspec
sudo gem install rake

# install oracle java 8 and set as default (should make this chef-like in the future)
sudo sh $(dirname $0)/install_oracle_java.sh

# set default JDK to be oracle java 8
sudo chef-apply $(dirname $0)/set_java_home.rb

# install tomcat
sudo chef-apply $(dirname $0)/install_tomcat.rb

# install postgres and set up required users/schemas/permissions for Tamr
sudo chef-apply $(dirname $0)/install_postgres.rb

# run serverspec to ensure everything is installed and running
#rake spec



