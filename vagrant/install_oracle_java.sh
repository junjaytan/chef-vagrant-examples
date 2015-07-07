# Installs Oracle Java 8, and sets it as the default JDK
# see: http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
# (needs to be run as root)
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update

# accept oracle license automatically
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# install oracle java
sudo apt-get -y install oracle-java8-installer

# set oracle java as default
sudo apt-get -y install oracle-java8-set-default
