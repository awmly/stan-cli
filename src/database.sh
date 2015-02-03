# Define syncdb method
elif [ "$METHOD" = "db" ]; then

  if [ "${ARGS[1]}" = "conf" ]; then

    # Get remote db variables from config
    DBHOST=$( getConfigVar "DBHOST" )
    DBUSER=$( getConfigVar "DBUSER" )
    DBPASS=$( getConfigVar "DBPASS" )

    # Create mysql cnf file
    echo "[client]" > database/remote.cnf
    echo "host = ${DBHOST}" >> database/remote.cnf
    echo "user = ${DBUSER}" >> database/remote.cnf
    echo "password = ${DBPASS}" >> database/remote.cnf

    # Get local db variables from config
    DBHOST=$( getConfigVar "DBHOST_LOCAL" )
    DBUSER=$( getConfigVar "DBUSER_LOCAL" )
    DBPASS=$( getConfigVar "DBPASS_LOCAL" )

    # Create mysql cnf file
    echo "[client]" > database/local.cnf
    echo "host = ${DBHOST}" >> database/local.cnf
    echo "user = ${DBUSER}" >> database/local.cnf
    echo "password = ${DBPASS}" >> database/local.cnf

    # Show complete text
    echo $HR
    echo $DBCONF
    echo $HR

  elif [ "${ARGS[1]}" = "remotetolocal" ]; then

    # Export the remote database
    stan db exportremote

    # Load the database in to local mysql server
    stan db importlocal

  elif [ "${ARGS[1]}" = "localtoremote" ]; then

    # Export the local database
    stan db exportlocal

    # Load the database in to remote mysql server
    stan db importremote

  elif [ "${ARGS[1]}" = "exportremote" ]; then

    # Export the local database
    exportRemoteDatabase

    # Show complete text
    echo $HR
    echo $EXPORTREMOTE
    echo $HR

  elif [ "${ARGS[1]}" = "exportlocal" ]; then

    # Export the local database
    exportLocalDatabase

    # Show complete text
    echo $HR
    echo $EXPORTLOCAL
    echo $HR

  elif [ "${ARGS[1]}" = "importremote" ]; then

    # Export the local database
    importRemoteDatabase

    # Show complete text
    echo $HR
    echo $IMPORTREMOTE
    echo $HR

  elif [ "${ARGS[1]}" = "importlocal" ]; then

    # Export the local database
    importLocalDatabase

    # Show complete text
    echo $HR
    echo $IMPORTLOCAL
    echo $HR

  fi
