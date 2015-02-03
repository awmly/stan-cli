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
