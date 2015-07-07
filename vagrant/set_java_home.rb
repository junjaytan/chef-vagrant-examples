# Export java home so tomcat knows to use oracle java

# The easiest way is to create a symlink so default java links to your oracle java 8 dir
# equivalent to: sudo ln -s /usr/lib/jvm/java-8-oracle/ /usr/lib/jvm/default-java
link "/usr/lib/jvm/default-java" do
  action :create
  link_type :symbolic
  owner 'root'
  to "/usr/lib/jvm/java-8-oracle" 
end



# The script below is an alternative method to set java home for etc/default/tomcat7
# but it only works if tomcat is already installed.
=begin
# see: http://askubuntu.com/questions/154953/specify-jdk-for-tomcat7
# see: http://www.rubydoc.info/gems/chef/Chef/Util/FileEdit
# you need to modify /etc/default/tomcat7

file_path='/etc/default/tomcat7'
java_home='/usr/lib/jvm/java-8-oracle/'

ruby_block "set JAVA_HOME to point to oracle JDK for Tomcat" do
  block do
    fe = Chef::Util::FileEdit.new("#{file_path}")
    
    # replace variable with correct path if it already exists
    fe.search_file_replace_line('^JAVA_HOME=', "JAVA_HOME=#{java_home}")
    
    # otherwise insert a new line with variable
    fe.insert_line_if_no_match('^JAVA_HOME=', "JAVA_HOME=#{java_home}")
    fe.write_file
  
  end
end

# restart tomcat after setting JAVA_HOME
service "tomcat7" do
  action :restart
end
=end
