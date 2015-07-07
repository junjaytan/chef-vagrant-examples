# Install AWS CLI
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install awscli


# Install virtualbox for Ubuntu Trusty Tahr 14.x
# see: http://www.howopensource.com/2013/04/install-virtualbox-ubuntu-ppa/
sudo apt-get install dkms
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update
sudo apt-get -y install virtualbox-4.3

# install vagrant
sudo apt-get install vagrant


# export virtualbox ovf
vboxmanage export 'ubuntu vagrant test' --output ~/Downloads/vagrant_test.ovf --ovf20
