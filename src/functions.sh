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


# Define sync database function
syncDatabase(){

  # Get SITE_URL from config
  SITE_URL=$( getConfigVar "SITE_URL" )

  # Drop all current tables
  mysql -u stan -pstan stan --execute='DROP TABLE IF EXISTS json, saconfig, saconfiggrp, saconfigparam, saextra, saextradata, saextramap, saextramodule, satmp, uploads'

  # Download DB from remote server
  wget ${SITE_URL}/scripts/export/database -O database.sql

  # Load database
  mysql -u stan -pstan stan < database.sql

}
