# Define syncdb method
elif [ "$METHOD" = "db" ]; then

  if [ "${ARGS[1]}" = "conf" ]; then

    # Get production db variables from config
    DBHOST=$( getConfigVar "DBHOST" )
    DBUSER=$( getConfigVar "DBUSER" )
    DBPASS=$( getConfigVar "DBPASS" )

    # Create production mysql cnf file
    echo "[client]" > database/production.cnf
    echo "host = ${DBHOST}" >> database/production.cnf
    echo "user = ${DBUSER}" >> database/production.cnf
    echo "password = ${DBPASS}" >> database/production.cnf

    # Get staging db variables from config
    DBHOST=$( getConfigVar "DBHOST_STAGING" )
    DBUSER=$( getConfigVar "DBUSER_STAGING" )
    DBPASS=$( getConfigVar "DBPASS_STAGING" )

    # Create staging mysql cnf file
    echo "[client]" > database/staging.cnf
    echo "host = ${DBHOST}" >> database/staging.cnf
    echo "user = ${DBUSER}" >> database/staging.cnf
    echo "password = ${DBPASS}" >> database/staging.cnf

    # Get local db variables from config
    DBHOST=$( getConfigVar "DBHOST_LOCAL" )
    DBUSER=$( getConfigVar "DBUSER_LOCAL" )
    DBPASS=$( getConfigVar "DBPASS_LOCAL" )

    # Create local mysql cnf file
    echo "[client]" > database/local.cnf
    echo "host = ${DBHOST}" >> database/local.cnf
    echo "user = ${DBUSER}" >> database/local.cnf
    echo "password = ${DBPASS}" >> database/local.cnf

    # Show complete text
    echo $HR
    echo $DBCONF
    echo $HR

  elif [ "${ARGS[1]}" = "synclocal" ]; then

    # Get staging server value
    STAGING_SERVER=$( getConfigVar "STAGING_SERVER" )

    # If staging server is active
    if [ "$STAGING_SERVER" = "1" ]; then

      # Export staging
      stan db exportstaging

    else

      # Export production
      stan db exportproduction

    fi

    # Import in to local
    stan db importlocal

  elif [ "${ARGS[1]}" = "exportproduction" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME" )

    # Run mysqldump command
    mysqldump --defaults-extra-file=database/production.cnf --complete-insert --default-character-set=utf8 $DBNAME ${ARGS[2]} > database/database.sql

    # Show complete text
    echo $HR
    echo $EXPORT
    echo $HR

  elif  [ "${ARGS[1]}" = "importproduction" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME" )

    # Load database
    mysql --defaults-extra-file=database/production.cnf $DBNAME < database/database.sql

    # Show complete text
    echo $HR
    echo $IMPORT
    echo $HR

  elif [ "${ARGS[1]}" = "exportstaging" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME_STAGING" )

    # Run mysqldump command
    mysqldump --defaults-extra-file=database/staging.cnf --complete-insert --default-character-set=utf8 $DBNAME ${ARGS[2]} > database/database.sql

    # Show complete text
    echo $HR
    echo $EXPORT
    echo $HR

  elif  [ "${ARGS[1]}" = "importstaging" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME_STAGING" )

    # Load database
    mysql --defaults-extra-file=database/staging.cnf $DBNAME < database/database.sql

    # Show complete text
    echo $HR
    echo $IMPORT
    echo $HR

  elif [ "${ARGS[1]}" = "exportlocal" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME_LOCAL" )

    # Run mysqldump command
    mysqldump --defaults-extra-file=database/local.cnf --complete-insert --default-character-set=utf8 $DBNAME ${ARGS[2]} > database/database.sql

    # Show complete text
    echo $HR
    echo $EXPORT
    echo $HR

  elif  [ "${ARGS[1]}" = "importlocal" ]; then

    # Get database name
    DBNAME=$( getConfigVar "DBNAME_LOCAL" )

    # Load database
    mysql --defaults-extra-file=database/local.cnf $DBNAME < database/database.sql

    # Show complete text
    echo $HR
    echo $IMPORT
    echo $HR

  else

    echo $HR
    echo $NOTFOUND
    echo $HR

  fi
