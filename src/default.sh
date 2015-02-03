# Define default action
elif [ "$METHOD" = "" ]; then

  # Rebase from rmeote
  stan rebase

  # Update libs
  grunt update

  # Open atom
  atom ./

  # Start mysql server
  mysql.server start

  # Get sync db value from config
  SYNC_DB=$( getConfigVar "SYNC_DB" )

  # If sync db is on then download remote database
  if [ "$SYNC_DB" = "1" ]; then

    exportRemoteDatabase

  fi

  # Import database.sql file in to local mysql server
  importLocalDatabase

  # Open frontend and backend in Chrome
  open -a 'Google Chrome' http://stan:4000/stan/
  open -a 'Google Chrome' http://stan:4000/

  # Start grunt server
  grunt serve
