# Define snapshot method
elif [ "$METHOD" = "snapshot" ]; then

  # Get domain
  DOMAIN=$( getConfigVar "DOMAIN" )

  # Set timestamp
  TIMESTAMP=$( date +"%Y-%m-%d_%H-%M-%S" )

  # Create db conf files
  stan db conf

  # Export production db
  stan db exportproduction

  # Move db to archive folder
  mv database/database.sql httpdocs/database.sql

  # Make archive directory
  tar -zcvf snapshots/${DOMAIN}-${TIMESTAMP}.tar.gz httpdocs/ > /dev/null

  # Show complete text
  echo -e $SNAPSHOT
