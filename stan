#! /bin/sh

######################################
#### STAN Command Line Interface #####
############ GLOBAL BIN ##############
########### VERSION 1.0.0 ############
######## DATE 17:13 - 05/02/15 #######
######################################

# Get passed arguments
METHOD="$1"
ARGS=("$@")

# Set vars
HR===============================================

# Set text colours
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Set complete strings
INIT="${HR}\n${GREEN}✔ INIT COMPLETE ${RESET}\nLocal server now initialised - Edit httpdocs/config/config.php and then run 'stan install'\n${HR}"
INITREMOTE="${HR}\n${GREEN}✔ INIT REMOTE COMPLETE ${RESET}\nRemote server is now configured - close the window and initialise local server\n${HR}"
INSTALL="${HR}\n${GREEN}✔ INSTALL COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing\n${HR}"
CLONE="${HR}\n${GREEN}✔ CLONE COMPLETE ${RESET}\nProject is now installed and set up - run stan to start developing\n${HR}"

# Set error strings
NOTEMPTY="${HR}\n${RED}ERROR ${RESET}\nDirectory is not empty\n${HR}"
NOSTAN="${HR}\n${RED}ERROR ${RESET}\nSTAN CLI is not installed - use grunt commands instead\n${HR}"

# Define install Grunt function
installGrunt(){

  npm install
  bower install
  composer install
  grunt update

}


# Define check if dir is empty function
checkIfDirIsEmpty(){

  # Check if dir is empty - except for git folder auto created by github app
  if  [ "$(ls -A | grep -v .git)" ]; then
    echo -e $NOTEMPTY
    exit 1
  fi

}


# Define check if stan is installed function
checkIfStanIsInstalled(){

  # Check if stan-cli file exists
  if [ ! -f "./stan-cli" ]; then
    echo -e $NOSTAN
    exit 1
  fi

}


# Define get config var function
getConfigVar(){

  # Include config file and echo out variable - discard any php warnings/notices
  php -r "include('httpdocs/config/config.php'); echo ${1};" 2> /dev/null

}


# Define prompt function
prompt(){

  # Confirm deployment
  echo -e ${1}

  # Show Y/N choices
  select YN in "Yes" "No"; do
      case $YN in
          Yes ) break;;
          No ) exit;;
      esac
  done

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
  echo -e $INIT

# Define install method
elif [ "$METHOD" = "install" ]; then

  # Create mysql config files
  stan db conf

  # Load database in to staging server
  stan db importstaging

  # Get config values from PHP
  DBNAME=$( getConfigVar "DBNAME_STAGING" )

  # Truncate uploads and satmp tables
  mysql --defaults-extra-file=database/staging.cnf $DBNAME --execute='TRUNCATE TABLE uploads;TRUNCATE TABLE satmp;'

  # Install node/grunt/bower/composer
  installGrunt

  # Perform inital commit
  git add .
  git commit -m 'Install project'
  git push origin master

  # Upload to server
  stan upload

  # Show complete text
  echo -e $INSTALL

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

  # Create new staging directory and change permissions
  sudo mkdir staging
  sudo chown ${USER}:${GROUP} staging staging/. staging/..

  # Create new database directory and change permissions
  sudo mkdir database
  sudo chown ${USER}:${GROUP} database database/. database/..

  # Create new snapshots directory and change permissions
  sudo mkdir snapshots
  sudo chown ${USER}:${GROUP} snapshots snapshots/. snapshots/..

  # Create new scripts directory and change permissions
  sudo mkdir scripts
  sudo chown ${USER}:${GROUP} scripts scripts/. scripts/..

  # Create stan-cli file and change permission
  sudo touch stan-cli
  sudo chown ${USER}:${GROUP} stan-cli
  sudo chmod +x stan-cli

  # Create uploads directory
  sudo mkdir uploads uploads/images uploads/downloads
  sudo chmod -R 0777 uploads

  # Show complete text
  echo -e $INITREMOTE

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
  echo -e $CLONE

# Define update method
elif [ "$METHOD" = "update" ]; then

  if [ "${ARGS[1]}" = "global" ]; then

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan -O /usr/bin/stan
    chmod +x /usr/bin/stan

  else

    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan-cli -O ./stan-cli
    chmod +x stan-cli

  fi

else

  # Check stan is installed
  checkIfStanIsInstalled

  # Load local stan-cli in project
  ./stan-cli $@

fi
