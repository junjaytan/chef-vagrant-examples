# Install augeas
# see:
#   http://stackoverflow.com/questions/15475642/how-to-install-ruby-augeas-gem-ubuntu-10-04
#   https://launchpad.net/ubuntu/+source/augeas
apt_package ['libaugeas-ruby', 'augeas-dbg', 'augeas-doc', 'augeas-lenses', 'augeas-tools'] do
  action :install
end

