# Define install method
elif [ "$METHOD" = "install" ]; then

  # Create mysql config files
  stan db conf

  # Load database in to local server
  stan db importlocal

  # Get config values from PHP
  DBNAME=$( getConfigVar "DBNAME" )

  # Truncate uploads and satmp tables
  mysql --defaults-extra-file=database/remote.cnf $DBNAME --execute='TRUNCATE TABLE uploads;TRUNCATE TABLE satmp;'

  # Install node/grunt/bower/composer
  installGrunt

  # Perform inital commit
  git add .
  git commit -m 'Install project'
  git push origin master

  # Upload to server
  stan upload

  # Show complete text
  echo $INSTALL
