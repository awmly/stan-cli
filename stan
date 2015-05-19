#! /bin/bash

######################################
#### STAN Command Line Interface #####
############ GLOBAL BIN ##############
########### VERSION 1.0.4 ############
######## DATE 09:02 - 19/05/15 #######
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
INIT="${GREEN}✔ INIT COMPLETE ${RESET}"
INIT2="Local server now initialised - Edit httpdocs/config/config.php and then run 'stan install'"
REMOTE="${GREEN}✔ INIT REMOTE COMPLETE ${RESET}"
REMOTE2="Remote server is now configured - close the window and initialise local server"
INSTALL="${GREEN}✔ INSTALL COMPLETE ${RESET}"
INTSALL2="Project is now installed and set up - run stan to start developing"
CLONE="${GREEN}✔ CLONE COMPLETE ${RESET}"
CLONE2="Project is now installed and set up - run stan to start developing"

# Set error strings
NOTEMPTY="${RED}ERROR ${RESET}"
NOTEMPTY2="Directory is not empty"
NOSTAN="${RED}ERROR ${RESET}"
NOSTAN2="STAN CLI is not installed - use grunt commands instead"

# Set Propts
UPDATEPROMPT="This will update the local copy of stan-cli overwriting any custom methdos for current project - are you sure?"

# Define get config var function
getConfigVar(){

  if [ -f "staging/config/config.php" ]; then

    DIR="staging/"

  else

    DIR="httpdocs/"

  fi

  # Include config file and echo out variable - discard any php warnings/notices
  php -r "include('${DIR}/config/config.php'); echo ${1};" 2> /dev/null

}

# Define prompt function
prompt(){

  # Confirm
  echo "${1}"

  # Show Y/N choices
  select YN in "Yes" "No"
  do
      case $YN in
          Yes ) break;;
          No ) exit;;
      esac
  done

}

# Define check if dir is empty function
checkIfDirIsEmpty(){

  # Check if dir is empty - except for git folder auto created by github app
  if  [ "$(ls -A | grep -v .git)" ]; then
    echo $HR
    echo "$NOTEMPTY"
    echo "$NOTEMPTY2"
    echo $HR
    exit 1
  fi

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
  echo $INIT2
  echo $HR

# Define install method
elif [ "$METHOD" = "install" ]; then

  # Create mysql config files
  stan db conf

  # Rename database so it can be imported
  mv install.sql database.sql

  # Load database in to staging server
  stan db importstaging

  # Get config values from PHP
  DBNAME=$( getConfigVar "DBNAME_STAGING" )

  # Truncate uploads and satmp tables
  mysql --defaults-extra-file=database/staging.cnf $DBNAME --execute='TRUNCATE TABLE uploads;TRUNCATE TABLE logs;'

  # Install node/bower/composer dependencies
  stan dependencies

  # Build JS/CSS libraries
  stan build

  # Perform inital commit
  git add .
  git commit -m 'Install project'
  git push origin master

  # Upload to server
  stan upload
  stan upload scripts

  # Show complete text
  echo $HR
  echo $INSTALL
  echo $INSTALL2
  echo $HR

# Define init-remote method
elif [ "$METHOD" = "remote" ]; then

  # Get user and group info
  USER="$(whoami)";
  GROUP="$(id -g -n $USER)";

  # Change permissions of httpdocs
  sudo chown -R ${USER}:${GROUP} httpdocs
  sudo chmod 0775 -R httpdocs

  # Make staging dierctory if needed and change permissions
  sudo mkdir -p staging
  sudo chown -R ${USER}:${GROUP} staging

  # Create new database directory and change permissions
  sudo mkdir -p database
  sudo chown -R ${USER}:${GROUP} database

  # Create new snapshots directory and change permissions
  sudo mkdir -p snapshots
  sudo chown -R ${USER}:${GROUP} snapshots

  # Create new scripts directory and change permissions
  sudo mkdir -p scripts
  sudo chown -R ${USER}:${GROUP} scripts

  # Create uploads directory
  sudo mkdir -p uploads uploads/images uploads/downloads
  sudo chown -R ${USER}:${GROUP} uploads
  sudo chmod -R 0777 uploads

  # Create stan-cli file and change permission
  sudo touch stan-cli
  sudo chown ${USER}:${GROUP} stan-cli
  sudo chmod 0700 stan-cli

  # Show complete text
  echo $HR
  echo $REMOTE
  echo $REMOTE2
  echo $HR

# Define clone method
elif [ "$METHOD" = "clone" ]; then

  # Check dir is empty
  checkIfDirIsEmpty

  # Remove git directory created by github app
  rm -rf .git

  # Set repo based on current dir
  REPO=${PWD##*/}

  # Clone repo in to current dir
  git clone git@gitlab.com:smartarts/${REPO}.git .

  # Install node/bower/composer dependencies
  stan dependencies

  # Build JS/CSS libraries
  stan build

  # Show complete text
  echo $HR
  echo $CLONE
  echo $CLONE2
  echo $HR

# Define update method
elif [ "$METHOD" = "update" ]; then

  if [ "${ARGS[1]}" = "global" ]; then

    # Download from github
    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan -O /usr/bin/stan

    # Set permissions
    chmod +x /usr/bin/stan

  else

    # Confirm update
    prompt "$UPDATEPROMPT"

    # Download from github
    wget https://raw.githubusercontent.com/awomersley/stan-cli/master/stan-cli -O ./stan-cli

    # Set permissions
    chmod +x stan-cli

  fi

else

  # Check if stan-cli file exists
  if [ -f "stan-cli" ]; then

    # Load local stan-cli in project
    ./stan-cli $@

  else

    # Show error text
    echo $HR
    echo $NOSTAN
    echo $NOSTAN2
    echo $HR
    exit 1

  fi

fi
