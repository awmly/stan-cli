#! /bin/sh

######################################
#### STAN Command Line Interface #####
######################################

# Get passed arguments
METHOD="$1";
ARG1="$2";
ARG2="$3";


# Get user and group info
USER="$(whoami)";
GROUP="$(id -g -n $USER)";


# Define install Grunt function
installGrunt(){
	npm install
	bower install
	composer install
	grunt update
}


# Define init method
if [ $METHOD = 'init' ]; then
	git clone git@gitlab.com:awomersley/stan.git $ARG1
	cd $ARG1
	rm -rf .git
	git init
	atom ./
fi


# Define install method
if [ $METHOD = 'install' ]; then
	installGrunt
	REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')
	git remote add origin git@gitlab.com:smartarts/${REPO}.git
	git add .
	git commit -m 'Install project'
	git push origin master
	grunt
fi


# Define install-server method
if [ $METHOD = 'install-server' ]; then
	sudo mkdir uploads
	chmod 0777 uploads
	chmod g+w httpdocs/
	rm -rf httpdocs/*
	sudo chown saadmin:saadmin httpdocs/. httpdocs/..
fi


# Define clone method
if [ $METHOD = 'clone' ]; then
	REPO=$(echo "${ARG1##*/}" | sed 's/\./-/g')
	git clone git@gitlab.com:smartarts/${REPO}.git $ARG1
	cd $ARG1
	installGrunt
	grunt
fi
