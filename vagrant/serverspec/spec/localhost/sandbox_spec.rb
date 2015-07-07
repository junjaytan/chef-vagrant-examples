require 'spec_helper'

##############
# Verify postgres and configs are set up appropriately
# see: http://blog.hashnao.info/2014/08/installing-postgresql-on-ec2-via-chef.html
describe package('postgresql-9.3'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('postgresql'), :if => os[:family] == 'ubuntu' do
  it { should be_running }
end

describe user('postgres') do
  it { should exist }
end

describe port(5432) do
  it { should be_listening }
end

# also should verify that tamr role, doit database, and tamr/staging schemas exist


# ##########
# # Verify tomcat
describe package('tomcat7'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('tomcat7'), :if => os[:family] == 'ubuntu' do
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

# Verify oracle java exists
describe command('java -version') do
  its(:stdout){ should include 'java version "1.8' }
end

