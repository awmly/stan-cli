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
