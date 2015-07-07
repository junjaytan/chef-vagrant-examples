File.open('/home/vagrant/tomcat7').each_line do |li|
  puts li if (li[/^JAVA_HOME=/])
end
