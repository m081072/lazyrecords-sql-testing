#!/usr/bin/env bash

debconf-set-selections <<< 'mysql-server mysql-server/root_password password MySuperPassword'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MySuperPassword'

add-apt-repository -y ppa:webupd8team/java
apt-get -y update

apt-get -y purge openjdk-\*
apt-get install -y git mysql-server-5.6 

sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

sudo apt-get -y install oracle-java8-installer > /dev/null

cd /home/vagrant
git clone https://github.com/bodar/lazyrecords.git
cp /vagrant/mysql.properties lazyrecords/test/com/googlecode/lazyrecords/sql/
chown -R vagrant:vagrant lazyrecords
cd lazyrecords
./jcompilo.sh
