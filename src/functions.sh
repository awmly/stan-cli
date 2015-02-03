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
