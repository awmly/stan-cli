# Define syncdb method
elif [ "$METHOD" = "syncdb" ]; then

  if [ "${ARGS[1]}" = "remotetolocal" ]; then

    # Export the remote database
    exportRemoteDatabase

    # Load the database in to local mysql server
    importLocalDatabase

    # Show complete text
    echo $HR
    echo $LOCAL
    echo $HR

  elif [ "${ARGS[1]}" = "localtoremote" ]; then

    # Export the local database
    exportLocalDatabase

    # Load the database in to remote mysql server
    importRemoteDatabase

    # Show complete text
    echo $HR
    echo $REMOTE
    echo $HR

  fi
