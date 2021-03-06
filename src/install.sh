# Define install method
elif [ "$METHOD" = "install" ]; then

  # Create mysql config files
  stan db conf

  # Rename database so it can be imported
  mv database/install.sql database/database.sql

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
  stan upload cache

  # Show complete text
  echo $HR
  echo $INSTALL
  echo $INSTALL2
  echo $HR
