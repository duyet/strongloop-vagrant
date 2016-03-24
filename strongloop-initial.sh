#!/usr/bin/env bash

# root su yourself
sudo su

export DEBIAN_FRONTEND=noninteractive

# way of checking if you we need to install everything
if [ ! -e "/var/node-app" ]; then
    # Add mongo to apt
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 &> /dev/null
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' \
		> /etc/apt/sources.list.d/mongodb.list


	echo "Installing dev tools.."
    apt-get install -y vim git curl build-essential

	echo "Installing mongodb..."
	apt-get install -y mongodb-org

	# Install Node
	echo "Installing node..."
	curl -sL https://deb.nodesource.com/setup_5.x | bash -
	apt-get install -y nodejs

	echo "Installing bower..."
	npm i -g bower
	echo "done."

	# Install StrongLoop
	echo "Installing strongloop..."
	npm install -g strongloop 
	echo "done."

	# Symlink our host node-apps to the guest /var/node-apps folder
	ln -s /vagrant/node-app /var/node-app

	echo " 'slc run /var/node-app/myApp/app.js' to run the strong node node app in node-app/myApp"
fi