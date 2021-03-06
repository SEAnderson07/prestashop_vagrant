#!/usr/bin/env bash

## Change this to the name you'd like for your new Spree folder
PS_FOLDER=prestashop

## Setup and basic tools
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y unzip

## Apache
sudo apt-get install -y apache2 libapache2-mod-php5

## MySQL and PHP
echo "mysql-server-5.5 mysql-server/root_password password abc123" | sudo debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password abc123" | sudo debconf-set-selections
sudo apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

## phpMyAdmin
sudo apt-get install -y phpmyadmin
sudo cp /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf

## Download Prestashop
cd /tmp
wget http://www.prestashop.com/download/old/prestashop_1.6.0.8.zip
unzip prestashop_1.6.0.8.zip
sudo rm -rf /vagrant/prestashop-old
sudo mv /vagrant/prestashop /vagrant/prestashop-old
sudo mv ./prestashop /vagrant

## Create a database
mysql -uroot -pabc123 -e 'create database prestashop'

## Restart Apache to get config changes
sudo apachectl -k restart
