#! /bin/sh

######################################
#### STAN Command Line Interface #####
########### VERSION 1.0.0 ############
######## DATE 11:28 - 29/01/15 #######
######################################

# Get passed arguments
METHOD="$1";
ARGS=("$@");

# Set vars
HR===============================================;

# Set text colours
GREEN=`tput setaf 2`
RESET=`tput sgr0`

# Set complete strings
INIT="${GREEN}✔ INIT COMPLETE ${RESET}\nLocal server now initialised - Edit httpdocs/config/config.php and then run 'stan install'"
INITREMOTE="${GREEN}✔ INIT REMOTE COMPLETE ${RESET}\nRemote server is now configured - close the window and initialise local server"
INSTALL="${GREEN}✔ INSTALL COMPLETE ${RESET}\nProject is now installed and set up - run the grunt command to start developing"
CLONE="${GREEN}✔ CLONE COMPLETE ${RESET}\nProject is now installed and set up - run the grunt command to start developing"

# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}

# Define get config var function
getConfigVar(){

  VAL="$(cat httpdocs/config/config.php | grep -m 1 $1 | cut -d \' -f 4)"
  echo $VAL;

}

# Define init method
if [ $METHOD = 'init' ]; then

  # Download stan archive and extract
  git archive --format=tar --remote=git@gitlab.com:awomersley/stan.git master | tar -xf -

  # Init git repo
  git init

  # Set repo based on directory name and add
  REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')
  git remote add origin git@gitlab.com:smartarts/${REPO}.git

  # Open atom
  atom ./

  # Show complete text
  echo $HR
  echo $INIT
  echo $HR

fi

# Define init-remote method
if [ "$METHOD" = "init-remote" ]; then

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

fi

# Define install method
if [ "$METHOD" = "install" ]; then

  # Get config values from PHP
  DBHOST=$( getConfigVar "DBHOST" )
  DBNAME=$( getConfigVar "DBNAME" )
  DBUSER=$( getConfigVar "DBUSER" )
  DBPASS=$( getConfigVar "DBPASS" )

  # Load database in to remote server
  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME < database.sql

  # Install node/grunt/bower/composer
  installGrunt

  # Perform inital commit
  git add .
  git commit -m 'Install project'
  git push origin master

  # Show complete text
  echo $HR
  echo $INSTALL
  echo $HR

fi

# Define clone method
if [ "$METHOD" = "clone" ]; then

  # Set repo based on current dir
  REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/grunt/bower/composer
  installGrunt

  # Show complete text
  echo $HR
  echo $CLONE
  echo $HR

fi
