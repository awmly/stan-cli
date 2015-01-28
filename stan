#! /bin/sh

######################################
#### STAN Command Line Interface #####
########### VERSION 1.0.0 ############
######## DATE 21:22 - 28/01/15 #######
######################################

# Get passed arguments
METHOD="$1";
ARGS=("$@");

# Define install Grunt function
installGrunt(){
  npm install
  bower install
  composer install
  grunt update
}

# Define init method
if [ $METHOD = 'init' ]; then
  mkdir ${ARGS[1]}
  cd ${ARGS[1]}
  git archive --format=tar --remote=git@gitlab.com:awomersley/stan.git master | tar -xf -
  git init
  REPO=$(echo "${PWD##*/}" | sed 's/\./-/g')
  git remote add origin git@gitlab.com:smartarts/${REPO}.git
  atom ./
  echo "Edit httpdocs/config/config.php and then run 'stan install'"
fi

# Define install-server method
if [ "$METHOD" = "install-remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  sudo mkdir uploads
  sudo chmod 0777 uploads
  sudo chmod g+w httpdocs/
  sudo rm -rf httpdocs/*
  sudo chown ${USER}:${GROUP} httpdocs/. httpdocs/..
  echo "Remote server configured"
fi

# Define install method
if [ "$METHOD" = "install" ]; then

  # Get config values from PHP
  DBHOST="$(cat httpdocs/config/config.php | grep -m 1 DBHOST | cut -d \' -f 4)"
  DBNAME="$(cat httpdocs/config/config.php | grep -m 1 DBNAME | cut -d \' -f 4)"
  DBUSER="$(cat httpdocs/config/config.php | grep -m 1 DBUSER | cut -d \' -f 4)"
  DBPASS="$(cat httpdocs/config/config.php | grep -m 1 DBPASS | cut -d \' -f 4)"

  mysql -h $DBHOST -u $DBUSER -p${DBPASS} $DBNAME < database.sql
fi

# Define clone method
if [ "$METHOD" = "clone" ]; then
  REPO=$(echo "${ARGS[1]##*/}" | sed 's/\./-/g')
  git clone git@gitlab.com:smartarts/${REPO}.git ${ARGS[1]}
  cd ${ARGS[1]}
  installGrunt
  echo "Close this window - Open the github app > file > add local repo > select directory"
fi
