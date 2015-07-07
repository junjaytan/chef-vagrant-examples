
postgres is located at...
* binaries: /usr/lib/postgresql/9.3/bin/postgres 
* default data dir: /var/lib/postgresql/9.3/main 
* default config_file: /etc/postgresql/9.3/main/postgresql.conf

to run postgres:
* switch to postgres user: su - postgres


tomcat7 binaries are located at /usr/share/tomcat7
tomcat7 webapp directory is located at:
* /usr/share/tomcat7-root, or alternatively
* /var/lib/tomcat7
tomcat7 logs are at: /var/lib/tomcat7/logs

/var/lib/tomcat7/webapps needs to be owned by tomcat7:tomcat7 user/group

#blah
sudo update-rc.d -f tomcat7 remove
sudo update-rc.d tomcat7 defaults


To start/stop tomcat, run:
* sudo service tomcat7 start
* sudo service tomcat7 stop


