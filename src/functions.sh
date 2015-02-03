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

  # Get database name
  DBNAME=$( getConfigVar "DBNAME" )

  # Run mysqldump command
  mysqldump --defaults-extra-file=database/remote.cnf --complete-insert --default-character-set=utf8 $DBNAME > database/database.sql

}

# Define get remote database function
exportLocalDatabase(){

  # Get database name
  DBNAME=$( getConfigVar "DBNAME_LOCAL" )

  # Run mysqldump command
  mysqldump --defaults-extra-file=database/local.cnf --complete-insert --default-character-set=utf8 $DBNAME > database/database.sql

}


# Define get remote database function
importRemoteDatabase(){

  # Get database name
  DBNAME=$( getConfigVar "DBNAME" )

  # Load database
  mysql --defaults-extra-file=database/remote.cnf $DBNAME < database/database.sql
}


# Define get remote database function
importLocalDatabase(){

  # Get database name
  DBNAME=$( getConfigVar "DBNAME_LOCAL" )

  # Load database
  mysql --defaults-extra-file=database/local.cnf $DBNAME < database/database.sql

}
