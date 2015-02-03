#! /bin/sh

######################################
#### STAN Command Line Interface #####
############ GLOBAL BIN ##############
########### VERSION 1.0.0 ############
######## DATE 10:32 - 03/02/15 #######
######################################

# Get passed arguments
METHOD="$1";
ARGS=("$@");

# Set vars
HR===============================================;

# Set text colours
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Set complete strings
INIT="${GREEN}✔ INIT COMPLETE ${RESET}\nLocal server now initialised - Edit httpdocs/config/config.php and then run 'stan install'"
INITREMOTE="${GREEN}✔ INIT REMOTE COMPLETE ${RESET}\nRemote server is now configured - close the window and initialise local server"
INSTALL="${GREEN}✔ INSTALL COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing"
CLONE="${GREEN}✔ CLONE COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing"

# Set error strings
NOTEMPTY="${RED}ERROR ${RESET}\nDirectory is not empty"
NOSTAN="${RED}ERROR ${RESET}\nSTAN CLI is not installed - use grunt commands instead"

# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}


# Define check if dir is empty function
checkIfDirIsEmpty(){

  # Check if dir is empty
  if  [ "$(ls -A)" ]; then
    echo $HR
    echo $NOTEMPTY
    echo $HR
    exit 1
  fi

}


# Define check if stan is installed function
checkIfStanIsInstalled(){

  # Check if stan-cli file exists
  if [ ! -f "./stan-cli" ]; then
    echo $HR
    echo $NOSTAN
    echo $HR
    exit 1
  fi

}


# Define get config var function
getConfigVar(){

  # Include config file and echo out variable
  php -r "include('httpdocs/config/config.php'); echo ${1};"

}


# Define get remote database function
exportRemoteDatabase(){

  # Get config values from PHP
  DBHOST=$( getConfigVar "DBHOST" )
  DBNAME=$( getConfigVar "DBNAME" )
  DBUSER=$( getConfigVar "DBUSER" )
  DBPASS=$( getConfigVar "DBPASS" )

  # Run mysqldump command
  mysqldump --complete-insert --default-character-set=utf8 --host=${DBHOST} --user=${DBUSER} --password=${DBPASS} $DBNAME > database.sql

}

# Define get remote database function
exportLocalDatabase(){

  # Run mysqldump command
  mysqldump --complete-insert --default-character-set=utf8 --user=stan --password=stan stan > database.sql

}


# Define get remote database function
importRemoteDatabase(){

  # Get config values from PHP
  DBHOST=$( getConfigVar "DBHOST" )
  DBNAME=$( getConfigVar "DBNAME" )
  DBUSER=$( getConfigVar "DBUSER" )
  DBPASS=$( getConfigVar "DBPASS" )

  # Drop all current tables
  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME --execute='DROP TABLE IF EXISTS json, saconfig, saconfiggrp, saconfigparam, saextra, saextradata, saextramap, saextramodule, satmp, uploads'

  # Load database
  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME < database.sql
}


# Define get remote database function
importLocalDatabase(){

  # Drop all current tables
  mysql -u stan -pstan stan --execute='DROP TABLE IF EXISTS json, saconfig, saconfiggrp, saconfigparam, saextra, saextradata, saextramap, saextramodule, satmp, uploads'

  # Load database
  mysql -u stan -pstan stan < database.sql

}

# Define init method
if [ "$METHOD" = "init" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Download stan archive and extract
  git archive --format=tar --remote=git@gitlab.com:awomersley/stan.git master | tar -xf -

  # Init git repo
  git init

  # Set repo based on directory name and add
  REPO=${PWD##*/}
  git remote add origin git@gitlab.com:smartarts/${REPO}.git

  # Open atom
  atom ./

  # Show complete text
  echo $HR
  echo $INIT
  echo $HR

# Define install method
elif [ "$METHOD" = "install" ]; then

  # Load database in to remote server
  importRemoteDatabase

  # Get config values from PHP
  DBHOST=$( getConfigVar "DBHOST" )
  DBNAME=$( getConfigVar "DBNAME" )
  DBUSER=$( getConfigVar "DBUSER" )
  DBPASS=$( getConfigVar "DBPASS" )

  # Truncate uploads and satmp tables
  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME --execute='TRUNCATE TABLE uploads;TRUNCATE TABLE satmp;'

  # Install node/grunt/bower/composer
  installGrunt

  # Perform inital commit
  git add .
  git commit -m 'Install project'
  git push origin master

  # Upload to server
  stan upload

  # Show complete text
  echo $HR
  echo $INSTALL
  echo $HR

# Define init-remote method
elif [ "$METHOD" = "remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  # Move httpdocs to plesk default
  sudo mv httpdocs/ plesk-default/

  # Create new httpdocs directory and change permissions
  sudo mkdir httpdocs
  sudo chown ${USER}:${GROUP} httpdocs httpdocs/. httpdocs/..

  # Create uploads directory
  sudo mkdir uploads
  sudo chmod 0777 uploads

  # Show complete text
  echo $HR
  echo $INITREMOTE
  echo $HR

# Define clone method
elif [ "$METHOD" = "clone" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Set repo based on current dir
  REPO=${PWD##*/}

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/grunt/bower/composer
  installGrunt

  # Show complete text
  echo $HR
  echo $CLONE
  echo $HR

# Define update method
elif [ "$METHOD" = "update" ]; then

  if [ "${ARGS[1]}" = "global" ]; then

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan
    chmod +x stan
    mv stan /usr/bin

  else

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan-cli
    chmod +x stan-cli

  fi

else

  # Check stan is installed
  checkIfStanIsInstalled

  # Load local stan-cli in project
  ./stan-cli $@

fi
